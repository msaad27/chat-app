import 'package:chat_app/Common/app_theme.dart';
import 'package:chat_app/controllers/theme_controller.dart';
import 'package:chat_app/controllers/auth_controller.dart';
import 'package:chat_app/controllers/home_controller.dart';
import 'package:chat_app/routes/app_pages.dart';
import 'package:chat_app/routes/app_route.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();

  final themeVM = Get.put(ThemeController());
  Get.lazyPut<AuthController>(() => AuthController(), fenix: true);
  Get.lazyPut<HomeController>(() => HomeController(), fenix: true);

  runApp(MyApp(themeVM: themeVM));
}

class MyApp extends StatelessWidget {
  final ThemeController themeVM;
  const MyApp({super.key, required this.themeVM});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GetMaterialApp(
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        themeMode: themeVM.themeMode,
        getPages: AppPages.pages,
        initialRoute: AppRoutes.login,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
