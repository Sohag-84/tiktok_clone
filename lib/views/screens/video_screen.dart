// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tiktok_clone/views/widgets/circle_animation.dart';
import 'package:tiktok_clone/views/widgets/video_player_item.dart';

class VideoScrenn extends StatelessWidget {
  const VideoScrenn({Key? key}) : super(key: key);

  buildProfile(String profilePhoto) {
    return SizedBox(
      height: 60.h,
      width: 60.w,
      child: Stack(
        children: [
          Positioned(
            left: 5.w,
            child: Container(
              height: 50.h,
              width: 50.w,
              padding: EdgeInsets.all(1.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25.r),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25.r),
                child: Image(
                  image: NetworkImage(profilePhoto),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  buildMusicAlbum(String profilePhoto) {
    return SizedBox(
      height: 60.h,
      width: 60.w,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(11.h),
            height: 50.h,
            width: 50.h,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.grey,
                  Colors.white,
                ],
              ),
              borderRadius: BorderRadius.circular(25.r),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25.r),
              child: Image(
                image: NetworkImage(profilePhoto),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: PageView.builder(
        itemCount: 5,
        controller: PageController(initialPage: 2, viewportFraction: 1),
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return Stack(
            children: [
              VideoPlayerItem(videoUrl: 'videoUrl'),
              Column(
                children: [
                  SizedBox(height: 100.h),
                  Expanded(
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.only(left: 20.h),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Username",
                                  style: TextStyle(
                                    fontSize: 20.sp,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "Caption",
                                  style: TextStyle(
                                    fontSize: 15.sp,
                                    color: Colors.white,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.music_note,
                                      size: 15.h,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      "song name",
                                      style: TextStyle(
                                        fontSize: 15.sp,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: 100.w,
                          margin: EdgeInsets.only(top: height / 5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              buildProfile('profilePhoto'),
                              Column(
                                children: [
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.favorite,
                                      size: 40.h,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(height: 7.h),
                                  Text(
                                    '3,234',
                                    style: TextStyle(
                                      fontSize: 20.sp,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.comment,
                                      size: 40.h,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(height: 7.h),
                                  Text(
                                    '234',
                                    style: TextStyle(
                                      fontSize: 20.sp,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.reply,
                                      size: 40.h,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(height: 7.h),
                                  Text(
                                    '34',
                                    style: TextStyle(
                                      fontSize: 20.sp,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              CircleAnimation(
                                child: buildMusicAlbum('profilePhoto'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
