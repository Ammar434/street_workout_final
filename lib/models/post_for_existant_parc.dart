import 'package:cloud_firestore/cloud_firestore.dart';

class PostForExistantParc {
  const PostForExistantParc({
    required this.postId,
    required this.userUidWhoPublish,
    required this.datePublished,
    required this.postUrl,
    required this.likes,
  });
  final String postId;
  final String userUidWhoPublish;
  final String datePublished;
  final String postUrl;
  final List likes;
  Map<String, dynamic> toJson() => {
        "postId": postId,
        "userNameWhoPublish": userUidWhoPublish,
        "datePublished": datePublished,
        "postUrl": postUrl,
        "likes": likes,
      };

  static PostForExistantParc postFromSnapshot(
      DocumentSnapshot documentSnapshot) {
    var snapshot = documentSnapshot.data() as Map<String, dynamic>;
    return PostForExistantParc(
        postId: snapshot['postId'],
        userUidWhoPublish: snapshot['userNameWhoPublish'],
        datePublished: snapshot['datePublished'],
        postUrl: snapshot['postUrl'],
        likes: snapshot['likes']);
  }
}
