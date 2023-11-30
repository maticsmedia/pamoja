import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'register_screen.dart';

class SecondSplashScreen extends StatelessWidget {
  const SecondSplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image with Opacity
          Opacity(
            opacity: 1.0,
            child: Image.asset(
              'assets/two-female-friends-hugging-while-out-city.jpg',
              fit: BoxFit.cover,
            ),
          ),
          // Opacity Layer
          DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.black,
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Colors.black.withOpacity(0.6)],
              ),
            ),
          ),
          // Content
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Your App Logo
              Image.asset(
                'assets/logo.png',
                height: 150.0,
                width: 150.0,
              ),
              const SizedBox(height: 20.0),
              // Description
              // Remove the text
              const SizedBox(height: 400.0),
              // Buttons with Borders and Highlight on Click
              ElevatedButton(
                onPressed: () {
                  // Navigate to Create Account Screen
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const RegisterScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors. white, shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ), backgroundColor: const Color(0xFF004751),
                  padding: const EdgeInsets.symmetric(horizontal: 100.0, vertical: 16.0),
                ),
                child: const Text('Create Account'),
              ),
              const SizedBox(height: 20.0),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors. white, shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ), backgroundColor: const Color(0xFFFF9C00),
                  padding: const EdgeInsets.symmetric(horizontal: 129.0, vertical: 16.0),
                ),
                child: const Text('Log In'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
