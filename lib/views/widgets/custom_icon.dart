// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class CustomIcon extends StatelessWidget {
  const CustomIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      width: 45,
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(left: 10),
            width: 38,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7),
              color: Color.fromARGB(255, 250, 45, 108),
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 10),
            width: 38,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7),
              color: Color.fromARGB(255, 32, 211, 234),
            ),
          ),
          Center(
            child: Container(
              width: 38,
              height: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(7),
              ),
              child: Icon(
                Icons.add,
                color: Colors.black,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
