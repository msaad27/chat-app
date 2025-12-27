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

  Future<void> deleteUser({
    required String email,
    required String password,
  }) async {
    final auth = FirebaseAuth.instance;
    final currentUser = auth.currentUser;
    if (currentUser == null) {
      throw Exception("No authenticated user found.");
    }
    final uid = currentUser.uid;
    final credential=EmailAuthProvider.credential(
      email: email,
      password: password,
    );
    await currentUser.reauthenticateWithCredential(credential);
    await _service.deleteUser(uid);
    await currentUser.delete();
    await auth.signOut();
  }

  @override
  void onClose() {
    aboutCtrl.dispose();
    nameCtrl.dispose();
    super.onClose();
  }
}
