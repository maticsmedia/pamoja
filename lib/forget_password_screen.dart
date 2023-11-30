import 'package:flutter/material.dart';

class ForgetPasswordScreen extends StatelessWidget {
  TextEditingController emailOrPhoneNumberController = TextEditingController();

  ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Forget Password',
          style: TextStyle(
            fontSize: 20.0,
            color: Color(0xFF004751),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF004751)),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Your App Logo or Image
            Image.asset(
              'assets/logo.png',
              height: 150.0,
              width: 150.0,
            ),
            const SizedBox(height: 20.0),
            // Email or Phone Number TextField
            TextField(
              style: const TextStyle(fontSize: 16.0),
              decoration: InputDecoration(
                labelText: 'Email or Phone Number',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 19.0),
              ),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // Perform forget password logic here
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ), backgroundColor: const Color(0xFF004751),
                padding: const EdgeInsets.symmetric(horizontal: 125.0, vertical: 19.0),
              ),
              child: const Text(
                'Reset Password',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
