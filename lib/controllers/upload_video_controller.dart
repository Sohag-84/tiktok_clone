import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/constants.dart';
import 'package:tiktok_clone/models/video_model.dart';
import 'package:video_compress/video_compress.dart';

class UploadVideoController extends GetxController {
  _compressedVideo(String videoPath) async {
    final compressedVideo = await VideoCompress.compressVideo(videoPath,
        quality: VideoQuality.MediumQuality);
    return compressedVideo!.file;
  }

//video compressed package generate auto thumbnail:
  _getThumnail(String videoPath) async {
    final videoThumbnail = await VideoCompress.getFileThumbnail(videoPath);
    return videoThumbnail;
  }

  Future<String> _uploadVideoToStorage(String id, String videoPath) async {
    Reference reference = firebaseStorage.ref().child('videos').child(id);
    UploadTask uploadTask =
        reference.putFile(await _compressedVideo(videoPath));
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();

    return downloadUrl;
  }

  //for video thumbnails
  Future<String> _uploadImageToStorage(String id, String videoPath) async {
    Reference reference = firebaseStorage.ref().child('thumbnails').child(id);
    UploadTask uploadTask = reference.putFile(await _getThumnail(videoPath));
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();

    return downloadUrl;
  }

  //upload video
  uploadVideo(
      {required String songName,
      required String caption,
      required String videoPath}) async {
    try {
      String uid = firebaseAuth.currentUser!.uid;
      DocumentSnapshot _userDocument = await firestore
          .collection('users')
          .doc(uid)
          .get(); //for get all user info

      //for video id
      var allDocs = await firestore.collection('videos').get();
      int len = allDocs.docs.length;
      //video file name like video 1,video 2
      String videoUr = await _uploadVideoToStorage("Video $len", videoPath);
      //video thumbnail
      String thumbnailUrl =
          await _uploadImageToStorage("Video $len", videoPath);

      var info = _userDocument.data()! as Map<String, dynamic>;
      VideoModel videoModel = VideoModel(
        username: info['username'],
        uid: uid,
        id: 'video $len',
        likes: [],
        commentCount: 0,
        shareCount: 0,
        songName: songName,
        caption: caption,
        videoUrl: videoUr,
        thumbnailUrl: thumbnailUrl,
        profilePhoto: info['profile_photo'],
      );

      //now save all the user collection in firebase
      firestore.collection('videos').doc('video $len').set(videoModel.toJson());
      Fluttertoast.showToast(msg: 'Uploading successful');
      Get.back();
    } catch (e) {
      Get.snackbar('Error uploading video', e.toString());
      Get.back();
    }
  }
}
