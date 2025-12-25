import 'package:chat_app/Models/user.dart';
import 'package:chat_app/services/user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ProfileController extends GetxController {
  final UserService _service;
  late UserModel user;
  late TextEditingController aboutCtrl;
  Rx<User?> currentUser = Rx<User?>(FirebaseAuth.instance.currentUser);

  ProfileController({required this.user, UserService? service})
    : _service = service ?? UserService() {
    aboutCtrl = TextEditingController(text: user.about);
  }

  Future<void> saveAbout() async {
    final text = aboutCtrl.text.trim();
    await _service.updateAbout(user.uid, text);
    user = UserModel(
      uid: user.uid,
      name: user.name,
      email: user.email,
      profilePic: user.profilePic,
      about: text,
    );
    update();
  }  

  @override
  void onClose() {
    aboutCtrl.dispose();
    super.onClose();
  }
}
