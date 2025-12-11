import 'package:chat_app/Common/widgets/app_text_field.dart';
import 'package:chat_app/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatelessWidget {
  final authController = Get.find<AuthController>();

  final name = TextEditingController();
  final email = TextEditingController();
  final pass = TextEditingController();

  SignUpScreen({super.key});

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sign Up")),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 500),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppTextField(
                  controller: name,
                  label: 'Name',
                  prefixIcon: Icons.person,
                ),
                SizedBox(height: 12),
                AppTextField(
                  controller: email,
                  label: 'Email',
                  prefixIcon: Icons.email,
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: 12),
                AppTextField(
                  controller: pass,
                  label: 'Password',
                  prefixIcon: Icons.lock,
                  obscureText: true,
                ),
                SizedBox(height: 20),
                Obx(
                  () => authController.loading.value
                      ? CircularProgressIndicator()
                      : SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () => authController.signUp(
                              name.text,
                              email.text,
                              pass.text,
                            ),
                            child: Text("Sign Up"),
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
