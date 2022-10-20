import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  String username;
  String profilePic;
  String email;
  String uid;

  UserModel({
    required this.username,
    required this.profilePic,
    required this.email,
    required this.uid,
  });

  Map<String, dynamic> toJson() => {
        'Username': username,
        'Profile-picture': profilePic,
        'Email': email,
        'Uid': uid,
      };
  //retrieve data from firebase
  static UserModel fromJson(DocumentSnapshot snapshot) {
    var snap = snapshot.data() as Map<String, dynamic>;
    return UserModel(
      username: snap['username'],
      profilePic: snap['profilePic'],
      email: snap['email'],
      uid: snap['uid'],
    );
  }
}
