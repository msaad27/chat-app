import 'package:chat_app/presentation/screens/chat_screen.dart';
import 'package:chat_app/controllers/chat_controller.dart';
import 'package:chat_app/presentation/screens/home_screen.dart';
import 'package:chat_app/presentation/screens/login_screen.dart';
import 'package:chat_app/presentation/screens/profile_screen.dart';
import 'package:chat_app/presentation/screens/signup_screen.dart';
import 'package:chat_app/routes/app_route.dart';
import 'package:get/get.dart';
import 'package:chat_app/controllers/profile_controller.dart';
import 'package:chat_app/Models/user.dart';

import '../presentation/screens/edit_profile.dart';

class AppPages {
  static final pages = [
    GetPage(name: AppRoutes.login, page: () => LoginScreen()),
    GetPage(name: AppRoutes.register, page: () => SignUpScreen()),
    GetPage(name: AppRoutes.home, page: () => HomeScreen()),
    GetPage(
      name: AppRoutes.chat,
      page: () => ChatScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<ChatController>(() => ChatController());
      }),
    ),
    GetPage(
      name: AppRoutes.profile,
      page: () => ProfileScreen(),
      binding: BindingsBuilder(() {
        final arg = Get.arguments;
        if (arg is UserModel) {
          Get.put(ProfileController(user: arg));
        }
      }),
    ),
    GetPage(name: AppRoutes.editProfile, page: () => EditProfileScreen()),
  ];
}
