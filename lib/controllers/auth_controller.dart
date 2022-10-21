// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok_clone/constants.dart';
import 'package:tiktok_clone/models/user_model.dart';
import 'package:tiktok_clone/views/screens/auth/login_screen.dart';
import 'package:tiktok_clone/views/screens/home_screen.dart';

class AuthController extends GetxController {
  static AuthController instence = Get.find();

  late Rx<File?> _pickedImage;
  late Rx<User?> _user;
  File? get profilePhoto => _pickedImage.value;

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(firebaseAuth.currentUser);
    _user.bindStream(firebaseAuth.authStateChanges());
    ever(_user, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    if (user == null) {
      Get.offAll(() => LoginScreen());
    } else {
      Get.offAll(() => HomeScreen());
    }
  }

  void pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    //final pickedImage2 = ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      Fluttertoast.showToast(msg: "Image selected");
    }
    _pickedImage = Rx<File?>(File(pickedImage!.path));
  }

  //upload image in firebase storage:
  Future<String> uploadToStorage(File image) async {
    Reference reference = firebaseStorage
        .ref()
        .child('Profile-Picture')
        .child(firebaseAuth.currentUser!.uid);
    UploadTask uploadTask = reference.putFile(image);
    TaskSnapshot snapshot = await uploadTask; // for get download url
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  void userRegistration(
      {required String username,
      required String email,
      required String password,
      File? image}) async {
    try {
      if (username.isNotEmpty &&
          email.isNotEmpty &&
          password.isNotEmpty &&
          image != null) {
        //store username, password, and email in firebase
        UserCredential credential = await firebaseAuth
            .createUserWithEmailAndPassword(email: email, password: password);
        String downloadUrl = await uploadToStorage(image);
        UserModel userModel = UserModel(
          username: username,
          profilePic: downloadUrl,
          email: email,
          uid: credential.user!.uid,
        );
        await firestore
            .collection('users')
            .doc(credential.user!.uid)
            .set(userModel.toJson());
        Fluttertoast.showToast(msg: "Registration successful");
      } else {
        Fluttertoast.showToast(msg: 'Please enter all the field');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Something is wrong!');
    }
  }

  //user login
  void userLogin(String email, String password) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password);
        //Fluttertoast.showToast(msg: 'login successful');
        print("login");
      } else {
        Get.snackbar('Login error', 'Please enter all the fields');
      }
    } catch (e) {
      Get.snackbar('Login error', e.toString());
    }
  }
}
