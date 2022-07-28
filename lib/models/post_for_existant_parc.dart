import 'package:cloud_firestore/cloud_firestore.dart';

class PostForExistantParc {
  const PostForExistantParc({
    required this.postId,
    required this.userUidWhoPublish,
    required this.datePublished,
    required this.postUrl,
    required this.likes,
    required this.isPublished,
  });
  final String postId;
  final String userUidWhoPublish;
  final String datePublished;
  final String postUrl;
  final List likes;
  final bool isPublished;
  Map<String, dynamic> toJson() => {
        "postId": postId,
        "userUidWhoPublish": userUidWhoPublish,
        "datePublished": datePublished,
        "postUrl": postUrl,
        "likes": likes,
        "isPublished": isPublished,
      };

  static PostForExistantParc postFromSnapshot(
      DocumentSnapshot documentSnapshot) {
    var snapshot = documentSnapshot.data() as Map<String, dynamic>;
    return PostForExistantParc(
      postId: snapshot['postId'],
      userUidWhoPublish: snapshot['userNameWhoPublish'],
      datePublished: snapshot['datePublished'],
      postUrl: snapshot['postUrl'],
      likes: snapshot['likes'],
      isPublished: snapshot['isPublished'],
    );
  }
}
