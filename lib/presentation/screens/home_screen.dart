import 'package:chat_app/controllers/home_controller.dart';
import 'package:chat_app/controllers/theme_controller.dart';
import 'package:chat_app/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  final homeController = Get.find<HomeController>();
  final themeController = Get.find<ThemeController>();
  final authController = Get.find<AuthController>();

  HomeScreen({super.key});

  @override
  Widget build(context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Chats"),
        actions: [
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.logout),
                tooltip: 'Logout',
                onPressed: () => authController.logout(),
              ),
              Obx(
                () => IconButton(
                  icon: Icon(
                    themeController.isDark.value
                        ? Icons.light_mode
                        : Icons.dark_mode,
                  ),
                  onPressed: themeController.toggleTheme,
                ),
              ),
            ],
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(55),
          child: Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              onChanged: homeController.search,
              decoration: InputDecoration(
                hintText: "Search users...",
                filled: true,
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
          ),
        ),
      ),
      body: Obx(() {
        if (homeController.filtered.isEmpty) {
          return Center(child: Text("No users"));
        }

        return ListView.builder(
          itemCount: homeController.filtered.length,
          itemBuilder: (_, i) {
            var u = homeController.filtered[i];

            return ListTile(
              leading: GestureDetector(
                onTap: () => Get.toNamed('/profile', arguments: u),
                child: CircleAvatar(
                  backgroundImage: u.profilePic.isEmpty
                      ? null
                      : NetworkImage(u.profilePic),
                ),
              ),
              title: Text(u.name),
              subtitle: Obx(() {
                final p = homeController.previews[u.uid];
                if (p == null || p.isEmpty) {
                  return Text(
                    u.about.isEmpty ? 'Tap to chat' : u.about,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  );
                }
                return Text(p, maxLines: 1, overflow: TextOverflow.ellipsis);
              }),
              // no trailing time shown
              onTap: () => Get.toNamed('/chat', arguments: u),
            );
          },
        );
      }),
    );
  }
}
