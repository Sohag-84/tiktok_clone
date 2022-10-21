import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:tiktok_clone/controllers/auth_controller.dart';

//Pages
const pages = [
  Center(child: Text("Home Screen")),
  Center(child: Text('Search Screen')),
  Center(child: Text('Add Screen')),
  Center(child: Text("Message Screen")),
  Center(child: Text("Profile Screen")),
];

//Colors
const backgroundColor = Colors.black;
var buttonColor = Colors.red[400];
const borderColor = Colors.grey;

//Firebase
var firebaseAuth = FirebaseAuth.instance;
var firestore = FirebaseFirestore.instance;
var firebaseStorage = FirebaseStorage.instance;

//Controller
var authController = AuthController.instence;
