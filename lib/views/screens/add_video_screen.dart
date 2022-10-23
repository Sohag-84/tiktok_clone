// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok_clone/constants.dart';
import 'package:tiktok_clone/views/screens/confirm_screen.dart';

class AddVideoScreen extends StatelessWidget {
  const AddVideoScreen({Key? key}) : super(key: key);

  pickVideo(ImageSource src) async {
    final video = await ImagePicker().pickVideo(source: src);
    if (video != null) {
      Get.to(
        () => ConfirmScreen(videoFile: File(video.path), videoPath: video.path),
      );
    }
  }

  showOptionDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        children: [
          SimpleDialogOption(
            onPressed: () => pickVideo(ImageSource.gallery),
            child: Row(
              children: [
                Icon(Icons.image),
                SizedBox(width: 3.w),
                Text(
                  'Gallery',
                  style: TextStyle(fontSize: 20.sp),
                )
              ],
            ),
          ),
          SimpleDialogOption(
            onPressed: () => pickVideo(ImageSource.camera),
            child: Row(
              children: [
                Icon(Icons.camera_alt),
                SizedBox(width: 3.w),
                Text(
                  'Camera',
                  style: TextStyle(fontSize: 20.sp),
                )
              ],
            ),
          ),
          SimpleDialogOption(
            onPressed: () => Get.back(),
            child: Row(
              children: [
                Icon(Icons.cancel),
                SizedBox(width: 3.w),
                Text(
                  'Cancel',
                  style: TextStyle(fontSize: 20.sp),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InkWell(
          onTap: () => showOptionDialog(context),
          child: Container(
            height: 50.h,
            width: 190.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.r),
              color: buttonColor,
            ),
            child: Center(
              child: Text(
                "Add Video",
                style: TextStyle(
                  fontSize: 20.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
