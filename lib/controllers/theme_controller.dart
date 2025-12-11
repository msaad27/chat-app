import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeController extends GetxController {
  final box = GetStorage();
  var isDark = false.obs;

  @override
  void onInit() {
    super.onInit();
    isDark.value = box.read('dark') ?? false;
  }

  ThemeMode get themeMode =>
      isDark.value ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme() {
    isDark.value = !isDark.value;
    box.write('dark', isDark.value);
  }
}
