import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

class SignUpView extends GetView<AuthController> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign Up')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 20),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                controller.signUpWithEmailAndPassword(
                  emailController.text.trim(),
                  passwordController.text.trim(),
                );
              },
              child: Text('Sign Up'),
            ),
            SizedBox(height: 20),
            TextButton(
              onPressed: () {
                Get.back(); // Navigate back to login view
              },
              child: Text('Already have an account? Sign In'),
            ),
          ],
        ),
      ),
    );
  }
}
