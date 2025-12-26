import 'package:chat_app/Models/user.dart';
import 'package:chat_app/services/user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ProfileController extends GetxController {
  final UserService _service;
  late UserModel user;
  late TextEditingController aboutCtrl;
  late TextEditingController nameCtrl;
  Rx<User?> currentUser = Rx<User?>(FirebaseAuth.instance.currentUser);

  ProfileController({required this.user, UserService? service})
    : _service = service ?? UserService() {
    aboutCtrl = TextEditingController(text: user.about);
    nameCtrl = TextEditingController(text: user.name);
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

  Future<void> editProfile() async {
    final updatedName = nameCtrl.text.trim();
    final updatedAbout = aboutCtrl.text.trim();

    if (updatedName.isNotEmpty && updatedName != user.name) {
      await _service.updateName(user.uid, updatedName);
      user.name = updatedName;
    }

    if (updatedAbout != user.about) {
      await _service.updateAbout(user.uid, updatedAbout);
      user.about = updatedAbout;
    }

    update();
  }

  @override
  void onClose() {
    aboutCtrl.dispose();
    nameCtrl.dispose();
    super.onClose();
  }
}
