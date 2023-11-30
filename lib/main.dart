import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pamoja/splash_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}


MaterialColor createMaterialColor(Color color) {
  List<int> strengths = <int>[50, 100, 200, 300, 400, 500, 600, 700, 800, 900];
  Map<int, Color> swatch = <int, Color>{};
  final int r = color.red, g = color.green, b = color.blue;

  for (int strength in strengths) {
    final double opacity = strength / 900.0;
    swatch[strength] = Color.fromRGBO(r, g, b, opacity);
  }

  return MaterialColor(color.value, swatch);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Roomie',
      theme: ThemeData(
        primarySwatch: createMaterialColor(const Color(0xFF004751)),
        scaffoldBackgroundColor: const Color(0xFFF8F8F8),
      ),
      home: const SplashScreen(),
    );
  }
}
