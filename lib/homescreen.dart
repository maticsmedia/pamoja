import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final VoidCallback? onLogout;

  const HomeScreen({super.key, this.onLogout});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome! You have logged in.',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Call the logout callback


                // Navigate back to the previous screen (assumed to be the login screen)
                Navigator.pop(context);
              },
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
