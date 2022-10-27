import 'package:cloud_firestore/cloud_firestore.dart';

class CommentModel {
  String username;
  String comment;
  final datePublished;
  List likes;
  String profilePhoto;
  String uid;
  String id;

  CommentModel({
    required this.username,
    required this.comment,
    required this.datePublished,
    required this.likes,
    required this.profilePhoto,
    required this.uid,
    required this.id,
  });

  Map<String, dynamic> toJson() => {
        'Username': username,
        'Comment': comment,
        'Date_published': datePublished,
        'Likes': likes,
        'Profile_photo': profilePhoto,
        'uid': uid,
        'id': id,
      };

  static CommentModel fromJson(DocumentSnapshot snapshot) {
    var snap = snapshot.data() as Map<String, dynamic>;
    return CommentModel(
      username: snap['Username'],
      comment: snap['Comment'],
      datePublished: snap['Date_published'],
      likes: snap['Likes'],
      profilePhoto: snap['Profile_photo'],
      uid: snap['uid'],
      id: snap['id'],
    );
  }
}
