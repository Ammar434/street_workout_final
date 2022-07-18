import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  const Post({
    required this.postId,
    required this.userUidWhoPublish,
    required this.parcId,
    required this.datePublished,
    required this.postUrl,
    required this.likes,
    required this.materialAvailable,
  });
  final String postId;
  final String userUidWhoPublish;
  final String parcId;
  final String datePublished;
  final List<String> postUrl;
  final List<String> materialAvailable;
  final likes;

  Map<String, dynamic> toJson() => {
        "postId": postId,
        "userNameWhoPublish": userUidWhoPublish,
        "parcId": parcId,
        "datePublished": datePublished,
        "postUrl": postUrl,
        "likes": likes,
        "materialAvailable": materialAvailable,
      };

  static Post postFromSnapshot(DocumentSnapshot documentSnapshot) {
    var snapshot = documentSnapshot.data() as Map<String, dynamic>;
    return Post(
      postId: snapshot['postId'],
      userUidWhoPublish: snapshot['userNameWhoPublish'],
      parcId: snapshot['parcId'],
      datePublished: snapshot['datePublished'],
      postUrl: snapshot['postUrl'],
      likes: snapshot['likes'],
      materialAvailable: snapshot['materialAvailable'],
    );
  }
}
