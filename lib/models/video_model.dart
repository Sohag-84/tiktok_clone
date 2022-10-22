import 'package:cloud_firestore/cloud_firestore.dart';

class VideoModel {
  String username;
  String uid;
  String id;
  List likes;
  int commentCount;
  int shareCount;
  String songName;
  String caption;
  String videoUrl;
  String thumbnailUrl;
  String profilePhoto;

  VideoModel({
    required this.username,
    required this.uid,
    required this.id,
    required this.likes,
    required this.commentCount,
    required this.shareCount,
    required this.songName,
    required this.caption,
    required this.videoUrl,
    required this.thumbnailUrl,
    required this.profilePhoto,
  });

  //to send date in firebase
  Map<String, dynamic> toJson() => {
        'username': username,
        'uid': uid,
        'id': id,
        'likes': likes,
        'comment_count': commentCount,
        'share_count': shareCount,
        'song_name': songName,
        'caption': caption,
        'video_url': videoUrl,
        'thumbnail': thumbnailUrl,
        'profile_photo': profilePhoto,
      };

  //get data from firebase
  static VideoModel fromJson(DocumentSnapshot snapshot) {
    var snap = snapshot.data() as Map<String, dynamic>;

    return VideoModel(
      username: snap['username'],
      uid: snap['uid'],
      id: snap['id'],
      likes: snap['likes'],
      commentCount: snap['commentCount'],
      shareCount: snap['shareCount'],
      songName: snap['songName'],
      caption: snap['caption'],
      videoUrl: snap['videoUrl'],
      thumbnailUrl: snap['thumbnailUrl'],
      profilePhoto: snap['profilePhoto'],
    );
  }
}
