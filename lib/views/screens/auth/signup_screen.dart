// ignore_for_file: prefer_const_constructors, camel_case_types, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/constants.dart';
import 'package:tiktok_clone/views/screens/auth/login_screen.dart';
import 'package:tiktok_clone/views/widgets/text_input_field.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({Key? key}) : super(key: key);

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "TikTok",
            style: TextStyle(
              color: buttonColor,
              fontSize: 35,
              fontWeight: FontWeight.w900,
            ),
          ),
          Text(
            "Register",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
          ),
          SizedBox(height: 20),
          Stack(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://www.daily-sun.com/assets/news_images/2021/09/25/Nikli.jpg'),
                backgroundColor: Colors.black,
                radius: 64,
              ),
              Positioned(
                bottom: -10,
                left: 80,
                child: IconButton(
                  onPressed: () => authController.pickImage(),
                  icon: Icon(Icons.add_a_photo),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: TextInputField(
              controller: _usernameController,
              icon: Icons.person,
              labelText: 'Username',
            ),
          ),
          SizedBox(height: 10),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: TextInputField(
              controller: _emailController,
              icon: Icons.email,
              labelText: 'Email',
            ),
          ),
          SizedBox(height: 10),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: TextInputField(
              controller: _passwordController,
              icon: Icons.lock,
              labelText: 'Password',
            ),
          ),
          SizedBox(height: 30),
          InkWell(
            onTap: () => authController.userRegistration(
              username: _usernameController.text,
              email: _emailController.text,
              password: _passwordController.text,
              image: authController.profilePhoto,
            ),
            child: Container(
              width: MediaQuery.of(context).size.width - 40,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: buttonColor,
              ),
              child: Center(
                child: Text(
                  "Sign up",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Already have an account?',
                style: TextStyle(fontSize: 15),
              ),
              TextButton(
                onPressed: () => Get.to(LoginScreen()),
                child: Text(
                  "Login",
                  style: TextStyle(
                    fontSize: 15,
                    color: buttonColor,
                    decoration: TextDecoration.underline,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
