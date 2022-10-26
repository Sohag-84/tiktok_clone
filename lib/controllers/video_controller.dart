import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/constants.dart';
import 'package:tiktok_clone/models/video_model.dart';

class VideoController extends GetxController {
  final Rx<List<VideoModel>> _videoList = Rx<List<VideoModel>>([]);

  List<VideoModel> get videoList => _videoList.value;

  @override
  void onInit() {
    super.onInit();
    _videoList.bindStream(
      firestore.collection('videos').snapshots().map(
        (QuerySnapshot query) {
          List<VideoModel> retVal = [];
          for (var element in query.docs) {
            retVal.add(
              VideoModel.fromJson(element),
            );
          }
          return retVal;
        },
      ),
    );
  }

  //for like video
  likeVideo(String id) async {
    DocumentSnapshot doc = await firestore.collection('videos').doc(id).get();
    var uid = authController.user.uid;

    if ((doc.data()! as dynamic)['likes'].contains(uid)) {
      //that means user already like this video
      await firestore.collection('videos').doc(id).update(
        {
          'likes': FieldValue.arrayRemove([uid]),
        },
      );
    } else {
      await firestore.collection('videos').doc(id).update(
        {
          'likes': FieldValue.arrayUnion([uid]),
        },
      );
    }
  }
}
