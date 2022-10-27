// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/controllers/search_controller.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);

  final SearchController searchController = Get.put(SearchController());
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: TextFormField(
            decoration: InputDecoration(
              filled: false,
              hintText: "Search",
              hintStyle: TextStyle(
                fontSize: 18.sp,
                color: Colors.white,
              ),
            ),
            onFieldSubmitted: (value) => searchController.userSearch(value),
          ),
        ),
        body: Center(
          child: searchController.searchedUser.isEmpty
              ? Text(
                  "Search for user",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                )
              : ListView.builder(
                  itemCount: searchController.searchedUser.length,
                  itemBuilder: (context, index) {
                    final userData = searchController.searchedUser[index];
                    return InkWell(
                      onTap: (){},
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(userData.profilePic),
                        ),
                        title: Text(
                          userData.username,
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    );
                  },
                ),
        ),
      );
    });
  }
}
