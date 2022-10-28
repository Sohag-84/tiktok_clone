import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/constants.dart';

class ProfileController extends GetxController {
  final Rx<Map<String, dynamic>> _user = Rx<Map<String, dynamic>>({});
  Map<String, dynamic> get user => _user.value;
  Rx<String> _uid = "".obs;

  updateUserId(String uid) {
    _uid.value = uid;
    getUserData();
  }

  getUserData() async {
    //for thumbnail
    List<String> thumbnail = [];
    var myVideos = await firestore
        .collection('videos')
        .where('uid', isEqualTo: _uid.value)
        .get();
    for (int i = 0; i < myVideos.docs.length; i++) {
      thumbnail.add((myVideos.docs[i].data() as dynamic)['thumbnail']);
    }
    //for user data
    DocumentSnapshot userDoc =
        await firestore.collection('users').doc(_uid.value).get();
    final userData = userDoc.data()! as dynamic;
    String name = userData['username'];
    String profilePhoto = userData['profile_photo'];
    int following = 0;
    int followers = 0;
    int likes = 0;
    bool isFollowing = false;

    //for likes
    for (var item in myVideos.docs) {
      likes += (item.data()['likes'] as List).length;
    }
    //for follower
    var followerDoc = await firestore
        .collection('users')
        .doc(_uid.value)
        .collection('followers')
        .get();
    //for following
    var followingDoc = await firestore
        .collection('users')
        .doc(_uid.value)
        .collection('following')
        .get();

    followers = followerDoc.docs.length;
    following = followingDoc.docs.length;

    //check user already follow or not
    firestore
        .collection('users')
        .doc(_uid.value)
        .collection("followers")
        .doc(authController.user.uid)
        .get()
        .then(
      (value) {
        if (value.exists) {
          isFollowing = true;
        } else {
          isFollowing = false;
        }
      },
    );

    _user.value = {
      'isFollowing': isFollowing,
      'following': following.toString(),
      'followers': followers.toString(),
      'likes': likes.toString(),
      'profile_photo': profilePhoto,
      'username': name,
      'thumbnails': thumbnail,
    };
    update();
  }

  followUser() async {
    var doc = await firestore
        .collection('users')
        .doc(_uid.value)
        .collection('followers')
        .doc(authController.user.uid)
        .get();

    if (!doc.exists) {
      await firestore
          .collection('users')
          .doc(_uid.value)
          .collection('followers')
          .doc(authController.user.uid)
          .set({});
      await firestore
          .collection('users')
          .doc(authController.user.uid)
          .collection('following')
          .doc(_uid.value)
          .set({});

      _user.value.update(
        'followers',
        (value) => (int.parse(value) + 1).toString(),
      );
    }
    else{
      await firestore
          .collection('users')
          .doc(_uid.value)
          .collection('followers')
          .doc(authController.user.uid)
          .delete();
      await firestore
          .collection('users')
          .doc(authController.user.uid)
          .collection('following')
          .doc(_uid.value)
          .delete();
      _user.value.update(
        'followers',
            (value) => (int.parse(value) - 1).toString(),
      );
    }
    _user.value.update('isFollowing', (value) => !value);
    update();
  }
}
