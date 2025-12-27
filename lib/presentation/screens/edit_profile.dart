import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/profile_controller.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProfileController>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () async {
              await controller.editProfile();
              Get.back();
              Get.snackbar('Saved', 'Profile updated');
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name'),
            SizedBox(height: 8),
            TextField(
              controller: controller.nameCtrl,
              decoration: InputDecoration(border: OutlineInputBorder()),
            ),
            SizedBox(height: 16),
            Text('About'),
            SizedBox(height: 8),
            TextField(
              controller: controller.aboutCtrl,
              maxLines: 4,
              decoration: InputDecoration(border: OutlineInputBorder()),
            ),
            SizedBox(height: 24),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      await controller.editProfile();
                      Get.back();
                      Get.snackbar('Saved', 'Profile updated');
                    },
                    child: Text('Save'),
                  ),
                  SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () {
                      showDeleteAccountDialog(Get.find<ProfileController>());
                    },
                    child: const Text("Delete Account"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showDeleteAccountDialog(ProfileController controller) {
    final TextEditingController passwordController = TextEditingController();

    Get.defaultDialog(
      title: "Delete Account",
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Please enter your password to confirm account deletion.",
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          TextField(
            controller: passwordController,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: "Password",
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
      textConfirm: "Delete",
      textCancel: "Cancel",
      confirmTextColor: Colors.white,
      onConfirm: () async {
        final user = FirebaseAuth.instance.currentUser;

        if (user == null || user.email == null) {
          Get.snackbar("Error", "No authenticated user found");
          return;
        }

        if (passwordController.text.trim().isEmpty) {
          Get.snackbar("Error", "Password cannot be empty");
          return;
        }

        try {
          await controller.deleteUser(
            email: user.email!,
            password: passwordController.text.trim(),
          );

          Get.back();
          Get.snackbar("Success", "Account deleted successfully");
          Get.offAllNamed('/login');
        } catch (e) {
          Get.snackbar("Error", e.toString());
        }
      },
    );
  }
}
