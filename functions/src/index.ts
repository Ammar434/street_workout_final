import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import fetch from "cross-fetch";

admin.initializeApp();

// exports.getParcReference = functions.https.onRequest((request, response) => {
//   const path = "parcs/e8db3560-1d76-11ed-bb5f-05f4c9f70e9b";
//   const promise = admin.firestore().doc(path).get();
//   const promise2 = promise.then(async (snapshot) => {
//     const data = snapshot.data();
//     if (data) {
//       const geoPoint = data.geoPoint;
//       const lat = Number(geoPoint.latitude);
//       const long = Number(geoPoint.longitude);
//       console.log(lat);
//       console.log(long);
//       addAddressToInitialParc("21348a01-a671-11ed-bfba-1d71535daea6");
//       // const a = await getConvertedData(lat, long);
//       // response.send(a.results[0].formatted_address);
//     } else {
//       response.send(data);
//     }
//   });
//   promise2.catch((error) => {
//     console.log(error);
//     response.status(500).send(error);
//   });
// });

// exports.getParcReference = functions.https.onRequest(
//   async (request, response) => {
//     const c = await addAddressToInitialParc(
//       "parcs/21348a01-a671-11ed-bfba-1d71535daea6"
//     );
//     response.send(c);
//   }
// );

async function addAddressToInitialParc(parcId: string, address: string) {
  // Obtain a document reference.
  const document = admin.firestore().doc("parcs/" + parcId);

  await document.set(
    {
      completeAddress: address,
    },
    { merge: true }
  );
}
async function reverseGeocoding(lat: number, long: number): Promise<string> {
  const APIKEY = "AIzaSyA26d1Ry88iBwQBYjsM3BTcJ7aMmvKosn8";
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
          $_id: {
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
// Une fonction qui ajoute nouveau user a liste leaderboard
// Une fonction qui trie leaderboard
