import 'package:chat_app/services/auth_service.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final service = AuthService();
  var loading = false.obs;

  Future<void> login(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      Get.snackbar('Error', 'Please enter email and password');
      return;
    }

    loading.value = true;
    try {
      final user = await service.login(email, password);
      if (user != null) {
        Get.offAllNamed('/home');
      } else {
        Get.snackbar('Error', 'User not found');
      }
    } catch (e) {
      Get.snackbar('Login Error', e.toString());
    } finally {
      loading.value = false;
    }
  }

  Future<void> signUp(String name, String email, String password) async {
    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      Get.snackbar('Error', 'Please fill all fields');
      return;
    }

    loading.value = true;
    try {
      final user = await service.signUp(email, password, name);
      if (user != null) {
        Get.offAllNamed('/home');
      } else {
        Get.snackbar('Error', 'Failed to register user');
      }
    } catch (e) {
      Get.snackbar('Registration Error', e.toString());
    } finally {
      loading.value = false;
    }
  }

  Future<void> logout() async {
    try {
      await service.signOut();
      Get.offAllNamed('/login');
    } catch (e) {
      Get.snackbar('Logout Error', e.toString());
    }
  }
}
