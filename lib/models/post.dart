import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  const Post({
    required this.postId,
    required this.userUidWhoPublish,
    // required this.profileImage,
    required this.parcId,
    required this.datePublished,
    required this.postUrl,
    required this.likes,
  });
  final String postId;
  final String userUidWhoPublish;
  // final String profileImage;
  final String parcId;
  final String datePublished;
  final String postUrl;

  final likes;

  Map<String, dynamic> toJson() => {
        "postId": postId,
        "userNameWhoPublish": userUidWhoPublish,
        // "profileImage": profileImage,
        "parcId": parcId,
        "datePublished": datePublished,
        "postUrl": postUrl,
        "likes": likes,
      };

  static Post postFromSnapshot(DocumentSnapshot documentSnapshot) {
    var snapshot = documentSnapshot.data() as Map<String, dynamic>;
    return Post(
      postId: snapshot['postId'],
      userUidWhoPublish: snapshot['userNameWhoPublish'],
      // profileImage: snapshot['profileImage'],
      parcId: snapshot['parcId'],
      datePublished: snapshot['datePublished'],
      postUrl: snapshot['postUrl'],
      likes: snapshot['likes'],
    );
  }
}
