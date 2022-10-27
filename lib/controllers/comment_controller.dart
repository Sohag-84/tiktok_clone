import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/constants.dart';
import 'package:tiktok_clone/models/comment_model.dart';

class CommentController extends GetxController {
  final Rx<List<CommentModel>> _comments = Rx<List<CommentModel>>([]);
  List<CommentModel> get comments => _comments.value;

  String _postId = "";

  updatedPostId({required String id}) {
    _postId = id;
    getComment();
  }

  getComment() async {}

  postComment(String commentText) async {
    try {
      if (commentText.isNotEmpty) {
        DocumentSnapshot userDoc = await firestore
            .collection('users')
            .doc(authController.user.uid)
            .get();

        var allDocs = await firestore
            .collection('videos')
            .doc(_postId)
            .collection("comments")
            .get();

        int len = allDocs.docs.length;
        var userData = userDoc.data()! as Map<String, dynamic>;

        CommentModel commentModel = CommentModel(
          username: userData['username'],
          comment: commentText.trim(),
          datePublished: DateTime.now(),
          likes: [],
          profilePhoto: userData['profile_photo'],
          uid: authController.user.uid,
          id: "comment $len",
        );
        //now save in firebase
        await firestore
            .collection('videos')
            .doc(_postId)
            .collection('comment')
            .doc("comment $len")
            .set(
              commentModel.toJson(),
            );
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }
}
