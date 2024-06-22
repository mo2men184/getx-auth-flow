import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

class PhoneAuthView extends GetView<AuthController> {
  final TextEditingController phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Phone Authentication')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: phoneNumberController,
              decoration: InputDecoration(labelText: 'Phone Number'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => controller.verifyPhoneNumber(phoneNumberController.text.trim()),
              child: Text('Verify Phone Number'),
            ),
          ],
        ),
      ),
    );
  }
}
