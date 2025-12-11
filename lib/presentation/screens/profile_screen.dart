import 'package:chat_app/Common/app_text.dart';
import 'package:chat_app/Models/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(context) {
    final UserModel user = Get.arguments as UserModel;

    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 30),
            CircleAvatar(
              radius: 60,
              backgroundImage: user.profilePic.isEmpty
                  ? null
                  : NetworkImage(user.profilePic),
            ),
            SizedBox(height: 20),
            Text(user.name, style: AppText.title),
            Text(user.email),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                user.about.isEmpty ? 'No bio' : user.about,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
