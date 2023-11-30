import 'package:flutter/material.dart';
import 'second_splash_screen.dart';
class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          Image.asset(
            'assets/afro-business.jpg',
            fit: BoxFit.cover,
          ),
          // Opacity Layer
          DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.9),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Colors.black.withOpacity(0.9)],
              ),
            ),
          ),
          // Content
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Your App Image
              const SizedBox(height: 550.0),
              // Centered Text
              const Center(
                child: Column(
                  children: [
                    Text(
                      'Tunakusaidia kutafta rafiki wa kulipa naye kodi pamoja',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10.0),

                  ],
                ),
              ),
              const SizedBox(height: 30.0),
              // Next Button
              InkWell(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const SecondSplashScreen()),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.0),
                    color: Color(0xFF004751),
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 15.0,
                    horizontal: 30.0,
                  ),
                  child: const Text(
                    'Get Started Now',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
