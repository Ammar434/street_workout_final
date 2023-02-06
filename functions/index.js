("use strict");

const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();

exports.addAllUserToLeaderboard = functions.pubsub
  .schedule("every day 00:00")
  .onRun(async (context) => {
    const collectionRef = db.collection("users");
    const snapshot = await collectionRef.get();
    if (snapshot.empty) {
      console.log("");
      return;
    }

    snapshot.forEach(async (doc) => {
      const data = doc.data();
      const name = data.name;
      const id = data.id;
      const profileImage = data.profileImage;
      const point = data.point;

      await db
        .collection("leaderboard")
        .doc("leaderboard_document")
        .set({
          list: db.FieldValue.arrayUnion({
            name: name,
            id: id,
            profileImage: profileImage,
            point: point,
          }),
        });

      functions.logger.log(doc.id, "=>", doc.data());
    });

    // functions.logger.log("User cleanup finished");
  });

exports.addNewUserToLeaderboard = functions.firestore
  .document("users/{userId}")
  .onCreate(async (snap, context) => {
    const data = snap.data();
    const name = data.name;
    const id = data.id;
    const profileImage = data.profileImage;
    const point = data.point;

    await db
      .collection("leaderboard")
      .doc("leaderboard_document")
      .set({
        list: db.FieldValue.arrayUnion({
          name,
          id,
          profileImage,
          point,
        }),
      });
  });
