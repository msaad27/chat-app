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
              child: Row(mainAxisAlignment: MainAxisAlignment.center,
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
                    onPressed: () async {
                      await controller.deleteUser();
                      Get.toNamed('/login');
                      Get.snackbar('Deleted', 'Profile deleted');
                    },
                    child: Text('Delete'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
