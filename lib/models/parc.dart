import 'package:cloud_firestore/cloud_firestore.dart';

class Parc {
  const Parc({
    required this.postId,
    required this.userUidWhoPublish,
    required this.parcId,
    required this.datePublished,
    required this.materialAvailable,
    required this.mainPhoto,
    required this.geoPoint,
    required this.name,
    required this.completeAddress,
    required this.userUidChampion,
    required this.athletesWhoTrainInThisParc,
    required this.isPublished,
  });
  final String postId;
  final String userUidWhoPublish;
  final String userUidChampion;
  final String parcId;
  final String datePublished;
  final String mainPhoto;
  final List<dynamic> materialAvailable;
  final List<dynamic> athletesWhoTrainInThisParc;
  final bool isPublished;
  final GeoPoint? geoPoint;
  final String name;
  final String completeAddress;

  Map<String, dynamic> toJson() => {
        "postId": postId,
        "userUidWhoPublish": userUidWhoPublish,
        "parcId": parcId,
        "datePublished": datePublished,
        "athletesWhoTrainInThisParc": athletesWhoTrainInThisParc,
        "materialAvailable": materialAvailable,
        "parcMainPhoto": mainPhoto,
        "geoPoint": geoPoint,
        "name": name,
        "completeAddress": completeAddress,
        "userUidChampion": userUidChampion,
        "isPublished": isPublished,
      };

  static Parc postFromSnapshot(DocumentSnapshot documentSnapshot) {
    var snapshot = documentSnapshot.data() as Map<String, dynamic>;
    return Parc(
      postId: snapshot['postId'],
      userUidWhoPublish: snapshot['userUidWhoPublish'],
      parcId: snapshot['parcId'],
      datePublished: snapshot['datePublished'],
      athletesWhoTrainInThisParc: snapshot['athletesWhoTrainInThisParc'],
      mainPhoto: snapshot['mainPhoto'],
      materialAvailable: snapshot['materialAvailable'],
      completeAddress: snapshot['completeAddress'],
      name: snapshot['name'],
      geoPoint: snapshot['geoPoint'],
      userUidChampion: snapshot['userUidChampion'],
      isPublished: snapshot['isPublished'],
    );
  }
}
