import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import fetch from "cross-fetch";

const fieldValue = admin.firestore.FieldValue;

admin.initializeApp();

exports.testPurposeOnly = functions.https.onRequest((request, response) => {
  const path = "leaderboard/leaderboard_document";

  const promise = admin.firestore().doc(path).get();

  const promise2 = promise.then(async (snapshot) => {
    const data = snapshot.data();
    if (data) {
      const a = await reverseGeocoding(10, 34);
      console.log(a);
      response.send("User added");
    } else {
      response.send("User not added");
    }
  });
  promise2.catch((error) => {
    console.log(error);
    response.status(500).send(error);
  });
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

exports.addParcReference = functions.firestore
  .document("parcs/{parcId}")
  .onCreate(async (snapshot) => {
    const newParc = snapshot.data();
    const _name = newParc.name;
    const _id = newParc.parcId;
    const _geoPoint = newParc.geoPoint;
    const lat = _geoPoint.latitude;
    const long = _geoPoint.longitude;
    const _completeAddress = await reverseGeocoding(lat, long);
    console.log("idé " + _id);
    await addAddressToInitialParc(_id, _completeAddress);

    await admin
      .firestore()
      .doc("datas/all_parcs_references")
      .set(
        {
          [_id]: {
            name: _name,
            id: _id,
            geoPoint: _geoPoint,
            completeAddress: _completeAddress,
          },
        },
        { merge: true }
      );
    // .then(() => {
    //   console.log("Parc " + _id + " added");
    //   return null;
    // })
    // .catch((error) => {
    //   console.log(error);
    //   return null;
    // });
  });

// Une fonction qui increment contribution user

async function incrementUserContribution(userId: string, incrementOf: number) {
  const document = admin.firestore().doc("users/" + userId);

  await document.update({
    numberOfContribution: fieldValue.increment(incrementOf),
  });
}

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

    try {
      return await incrementUserContribution(userId, pointToIncrement);
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
    const userId = data.userUidWhoPublish;

    try {
      return await incrementUserContribution(userId, pointToIncrement);
    } catch (e) {
      return "caught ";
    }
  });

// // Une fonction qui ajoute nouveau user a list leaderboard

async function addUserToLeaderboard(
  id: string,
  name: string,
  image: string,
  point: number
) {
  console.log("id " + id);
  console.log("name " + name);
  console.log("image " + image);
  console.log("point " + point);

  return await admin
    .firestore()
    .doc("leaderboard/leaderboard_document")
    .update({
      list: fieldValue.arrayUnion({
        userName: name,
        userId: id,
        userPoint: point,
        userProfileImage: image,
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

    return addUserToLeaderboard(_id, _name, _userProfileImage, _userPoint);
  });

// // Une fonction qui trie leaderboard

exports.sortLeaderboard = functions.pubsub
  .schedule("every 130 minutes")
  .onRun(async (context) => {
    console.log("This will be run every 130 minutes!");

    const path = "leaderboard/leaderboard_document";

    const promise = await admin.firestore().doc(path).get();
    const data = promise.data();
    if (data) {
      let listOfAllUser = data.list;

      listOfAllUser = listOfAllUser.sort((a: any, b: any) => {
        return b.userPoint - a.userPoint;
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

//Avoir le document quand isChallengeEnd finit pour les 2

// Verifier si challenge success
//Increment nb challenge evaluator
// increment nb challenge challenger et ajouter liste challenge si succes

exports.simpleDbFunction = functions.database
  .ref("/{parcId}/evaluator/{evaluatorId}")
  .onWrite(async (snap, context) => {
    const challengeData = snap.after.val();
    const challengeEndEvaluator = challengeData.isChallengeEndEvaluator;
    const challengeEndChallenger = challengeData.isChallengeEndChallenger;

    if (challengeEndChallenger != true && challengeEndEvaluator != true) {
      return null;
    }
    const 
    console.log("Challenge End Evaluator");



    return null;

    // if (context.authType === "ADMIN") {
    //   // do something
    // } else if (context.authType === "USER") {
    //   console.log(snap.val(), "written by", context.auth.uid);
    // }
  });
