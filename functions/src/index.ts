import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import fetch from "cross-fetch";
import * as geofire from "geofire-common";
import { v4 as uuidv4 } from "uuid";
import { GeoPoint } from "firebase-admin/firestore";
const fieldValue = admin.firestore.FieldValue;

admin.initializeApp();

// ##########################################################################################
// User function
// ##########################################################################################
async function incrementUserContribution(userId: string, incrementOf: number) {
  const document = admin.firestore().doc("users/" + userId);
  await document.update({
    numberOfContribution: fieldValue.increment(incrementOf),
  });
}
// ##########################################################################################

// ##########################################################################################
// Parc function
// ##########################################################################################
exports.createNewParc = functions.https.onRequest(async (request, response) => {
  const _parcId = uuidv4();
  const _parcName = request.query.name;
  const _materialAvailable = request.query.materialAvailable;
  const _completeAddress = request.query.completeAddress;
  let point = [0, 0];

  if (typeof _completeAddress === "string") {
    point = await geocoding(_completeAddress);
  }
  const _lat = point[0];
  const _long = point[1];

  const _geopoint = new GeoPoint(_lat, _long);
  const _geoHash = geofire.geohashForLocation([_lat, _long], 5);
  try {
    await admin.firestore().collection("parcs").doc(_parcId).set({
      postId: _parcId,
      userUidWhoPublish: "M4qhuxrn6FVEigyVITg0elgHgfN2",
      parcId: _parcId,
      datePublished: Date.now(),
      athletesWhoTrainInThisParc: [],
      materialAvailable: _materialAvailable,
      geoPoint: _geopoint,
      name: _parcName,
      completeAddress: _completeAddress,
      userUidChampion: "",
      isPublished: true,
      geoHash: _geoHash,
      mainPhoto: "",
    });
    if (typeof _parcName === "string" && typeof _completeAddress === "string") {
      await addToAllParcReference(
        _parcId,
        _parcName,
        _lat,
        _long,
        _completeAddress
      );
    }

    response.status(200).send("Ok");
  } catch (e) {
    response.status(400).send(`error ${e}`);
  }
});

async function addAddressToInitialParc(parcId: string, address: string) {
  const document = admin.firestore().doc("parcs/" + parcId);

  await document.set(
    {
      completeAddress: address,
    },
    { merge: true }
  );
}

async function addLatLongToInitialParc(
  parcId: string,
  lat: number,
  long: number
) {
  const geopoint = new GeoPoint(lat, long);

  const document = admin.firestore().doc("parcs/" + parcId);

  await document.set(
    {
      geoPoint: geopoint,
    },
    { merge: true }
  );
}

async function addToAllParcReference(
  parcId: string,
  name: string,
  lat: number,
  long: number,
  completeAddress: string
) {
  const geoPoint = new GeoPoint(lat, long);

  await admin
    .firestore()
    .doc("datas/all_parcs_references")
    .set(
      {
        [parcId]: {
          name: name,
          id: parcId,
          geoPoint: geoPoint,
          completeAddress: completeAddress,
        },
      },
      { merge: true }
    );
}

async function reverseGeocoding(lat: number, long: number): Promise<string> {
  const APIKEY = process.env.GOOGLEMAPKEY as string;
  const MAINURL = "https://maps.googleapis.com/maps/api/geocode/json";
  const uri = `${MAINURL}?latlng=${lat},${long}&key=${APIKEY}`;
  console.log(uri);
  const response = await fetch(uri);
  const data = await response.json();
  const completeAddress = data.results[0].formatted_address;

  return completeAddress;
}

async function geocoding(address: string): Promise<[number, number]> {
  const APIKEY = process.env.GOOGLEMAPKEY as string;
  const MAINURL = "https://maps.googleapis.com/maps/api/geocode/json";
  const uri = `${MAINURL}?address=${address}&key=${APIKEY}`;
  console.log(uri);
  const response = await fetch(uri);
  const data = await response.json();

  const lat = data.results[0].geometry.location.lat;
  const long = data.results[0].geometry.location.lng;
  console.log(`lat ${lat}`);
  console.log(`long ${long}`);

  return [lat, long];
}

async function addGeoHash(parcId: string, lat: number, lng: number) {
  const hash = await geofire.geohashForLocation([lat, lng], 5);
  const document = admin.firestore().doc("parcs/" + parcId);

  await document.update({
    geoHash: hash,
  });
}
async function addParcPhoto(parcId: string, photoUrl: string) {
  console.log("parcId");
  console.log(parcId);
  const document = await admin
    .firestore()
    .doc("parcs/" + parcId)
    .get();

  const data = document.data();
  if (data != null) {
    const mainUrl = data.mainPhoto;
    if (mainUrl == "") {
      await admin
        .firestore()
        .doc("parcs/" + parcId)
        .update({
          mainPhoto: photoUrl,
        });
    }
  }
}
exports.addParcReference = functions.firestore
  .document("parcs/{parcId}")
  .onCreate(async (snapshot) => {
    const newParc = snapshot.data();
    const _id = newParc.parcId;
    let _completeAddress = newParc.completeAddress;
    const _geoPoint = newParc.geoPoint;
    let _lat = _geoPoint.latitude;
    let _long = _geoPoint.longitude;
    if (_lat == 0 && _long == 0) {
      const geoPoint = await geocoding(_completeAddress);
      _lat = geoPoint[0];
      _long = geoPoint[1];
      await addLatLongToInitialParc(_id, _lat, _long);
    } else if (_completeAddress == "") {
      _completeAddress = await reverseGeocoding(_lat, _long);
      await addAddressToInitialParc(_id, _completeAddress);
    }

    await addGeoHash(_id, _lat, _long);
  });

exports.listenToParcValidate = functions.firestore
  .document("parcs/{parcId}")
  .onUpdate(async (change, context) => {
    const pointToIncrement = 5;

    // Retrieve the current and previous value
    const data = change.after.data();
    const previousData = change.before.data();

    // We'll only update if the parc has been validate by a admin.
    // This is crucial to prevent infinite loops.
    if (data.isPublished == previousData.isPublished) {
      return null;
    }

    // Retrieve the user who publish this parc
    const userId = data.userUidWhoPublish;
    const _name = data.name;
    const _id = data.parcId;
    const _completeAddress = data.completeAddress;
    const _geoPoint = data.geoPoint;
    const _lat = _geoPoint.latitude;
    const _long = _geoPoint.longitude;
    try {
      await addToAllParcReference(_id, _name, _lat, _long, _completeAddress);
      await incrementUserContribution(userId, pointToIncrement);
      return "Success";
    } catch (e) {
      return "caught ";
    }
  });

exports.listenToParcPhotoValidate = functions.firestore
  .document("parcs/{parcId}/posts/{postId}")
  .onUpdate(async (change, context) => {
    const pointToIncrement = 1;

    // Retrieve the current and previous value
    const data = change.after.data();
    const previousData = change.before.data();
    // We'll only update if the parc has been validate by a admin.
    // This is crucial to prevent infinite loops.
    if (data.isPublished == previousData.isPublished) {
      return null;
    }

    // Retrieve the user who publish this parc
    const parcId = change.after.ref.parent.parent?.id;
    console.log("parcId");
    console.log(parcId);
    const userId = data.userUidWhoPublish;

    try {
      await incrementUserContribution(userId, pointToIncrement);
      await addParcPhoto(parcId!, data.postUrl);
      return "Success";
    } catch (e) {
      return "caught ";
    }
  });

// ##########################################################################################

// ##########################################################################################
// Leaderboard
// ##########################################################################################

// // Une fonction qui ajoute nouveau user a list leaderboard

async function addUserToLeaderboard(
  id: string,
  name: string,
  image: string,
  point: number,
  numberOfEvaluation: number,
  numberOfContribution: number
) {
  return await admin
    .firestore()
    .doc("leaderboard/leaderboard_document")
    .update({
      list: fieldValue.arrayUnion({
        userName: name,
        userId: id,
        userPoint: point,
        userProfileImage: image,
        numberOfEvaluation: numberOfEvaluation,
        numberOfContribution: numberOfContribution,
      }),
    });
}

exports.addNewUserToLeaderboard = functions.firestore
  .document("users/{userId}")
  .onCreate(async (snapshot) => {
    const newUser = snapshot.data();

    const _name = newUser.userName;
    const _id = newUser.uid;
    const _userProfileImage = newUser.profileImage;
    const _userPoint = newUser.points;
    const _numberOfEvaluation = newUser.numberOfEvaluation;
    const _numberOfContribution = newUser.numberOfContribution;

    return addUserToLeaderboard(
      _id,
      _name,
      _userProfileImage,
      _userPoint,
      _numberOfEvaluation,
      _numberOfContribution
    );
  });

// // Une fonction qui trie leaderboard

exports.sortLeaderboard = functions.pubsub
  .schedule("every 3600 minutes")
  .onRun(async (context) => {
    console.log("This will be run every 300 minutes!");

    const path = "leaderboard/leaderboard_document";

    const promise = await admin.firestore().doc(path).get();
    const data = promise.data();
    if (data) {
      let listOfAllUser = data.list;
      listOfAllUser = listOfAllUser.sort(async (a: any, b: any) => {
        const userAPoint = await getUserPoint(a.uid);
        const userBPoint = await getUserPoint(b.uid);

        return userBPoint - userAPoint;
      });
      await admin.firestore().doc("leaderboard/leaderboard_document").set(
        {
          list: listOfAllUser,
        },
        { merge: true }
      );
    } else {
      console.log("Error during sorting");
    }

    return null;
  });

exports.getTheTopUserOfEachParc = functions.pubsub
  .schedule("every 3600 minutes")
  .onRun(async (context) => {
    console.log("This will be run every 3600 minutes!");

    const path = "parcs";

    const promise = await admin.firestore().collection(path).get();
    let athleteWithMostPoint = "";
    // Iterate over all parc in database
    promise.forEach(async (doc) => {
      const data = doc.data();
      const parcId = data.parcId;

      const listUser = data.athletesWhoTrainInThisParc;
      athleteWithMostPoint = listUser.reduce(
        (prev: string, current: string) => {
          const athleteAPoint = getUserPoint(prev);
          const athleteBPoint = getUserPoint(current);

          return athleteAPoint > athleteBPoint ? prev : current;
        }
      );
      await admin.firestore().doc(`parcs/${parcId}`).set(
        {
          userUidChampion: athleteWithMostPoint,
        },
        { merge: true }
      );
    });

    return "Success";
  });

// Avoir le document quand isChallengeEnd finit pour les 2

// Verifier si challenge success
// Increment nb challenge evaluator
// increment nb challenge challenger et ajouter liste challenge si succes

async function incrementUserPoint(userId: string, incrementOf: number) {
  const document = admin.firestore().doc("users/" + userId);
  return await document.update({
    points: fieldValue.increment(incrementOf),
  });
}

async function incrementUserEvaluation(userId: string, incrementOf: number) {
  const document = admin.firestore().doc("users/" + userId);

  return await document.update({
    numberOfEvaluation: fieldValue.increment(incrementOf),
  });
}

async function addRewardToUser(userId: string, reward: string) {
  return await admin
    .firestore()
    .doc(`users/${userId}`)
    .update({
      rewards: fieldValue.arrayUnion(reward),
    });
}

async function getUserPoint(userId: string): Promise<number> {
  const promise = await admin
    .firestore()
    .doc("users/" + userId)
    .get();
  const data = promise.data();

  const point =
    data!.userPoint +
    data!.numberOfEvaluation * 5 +
    data!.numberOfContribution * 2;

  return point;
}

// ##########################################################################################
// Challenge
// ##########################################################################################
exports.listenToChallengeFinished = functions.database
  .ref("/{parcId}/evaluator/{evaluatorId}")
  .onWrite(async (snap, context) => {
    const challengeData = snap.after.val();
    const challengeEndEvaluator = challengeData.isChallengeEndEvaluator;
    const challengeEndChallenger = challengeData.isChallengeEndChallenger;

    if (challengeEndChallenger != true && challengeEndEvaluator != true) {
      return null;
    }
    const executionRating = challengeData.executionRating;
    const repetitionRating = challengeData.repetitionRating;

    if (executionRating == -1 && repetitionRating == -1) {
      return null;
    }
    // Increment evaluator contribution
    const evaluatorId = challengeData.evaluatorUid;
    await incrementUserEvaluation(evaluatorId, 1);

    // Challenge is succeeded
    if ((executionRating + repetitionRating) / 2 >= 3) {
      const challengerId = challengeData.challengerUid;
      const rewardId = challengeData.challengeId;
      await incrementUserPoint(challengerId, 1);

      await addRewardToUser(challengerId, rewardId);
    }

    await console.log("Challenge End Evaluator");

    snap.after.ref.remove();
    return null;

    // if (context.authType === "ADMIN") {
    //   // do something
    // } else if (context.authType === "USER") {
    //   console.log(snap.val(), "written by", context.auth.uid);
    // }
  });
// ##########################################################################################
