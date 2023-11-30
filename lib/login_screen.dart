import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'forget_password_screen.dart';
import 'register_screen.dart';
import 'homescreen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/logo.png',
                height: 150.0,
                width: 150.0,
              ),
              const SizedBox(height: 20.0),
              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                style: const TextStyle(fontSize: 16.0),
                decoration: InputDecoration(
                  labelText: 'Enter Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 19.0),
                ),
              ),
              const SizedBox(height: 20.0),
              TextField(
                controller: passwordController,
                obscureText: true,
                style: const TextStyle(fontSize: 16.0),
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 19.0),
                ),
              ),
              const SizedBox(height: 5.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ForgetPasswordScreen()),
                      );
                    },
                    child: const Text(
                      'Forgot Password?',
                      style: TextStyle(
                        color: Color(0xFFFF9C00),
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5.0),
              ElevatedButton(
                onPressed: isLoading
                    ? null
                    : () async {
                        setState(() {
                          isLoading = true;
                        });

                        try {
                          // Perform email and password validation
                          if (emailController.text.isEmpty || passwordController.text.isEmpty) {
                            // Show an alert for empty email or password
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  content: Container(
                                    padding: const EdgeInsets.symmetric(vertical: 1),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Icon(
                                          FontAwesomeIcons.exclamationTriangle,
                                          color: Colors.orange,
                                        ),
                                        const SizedBox(height: 10.0),
                                        const Text("Please enter both email and password."),
                                        const SizedBox(height: 10.0),
                                        ElevatedButton(
                                          onPressed: () {
                                            Navigator.pop(context); // Close the alert dialog
                                          },
                                          style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(10.0),
                                              side: const BorderSide(color: Color(0xFF004751)),
                                            ),
                                          ),
                                          child: const Text("OK"),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                            setState(() {
                              isLoading = false;
                            });
                            return; // Exit the function to prevent further execution
                          }

                          UserCredential userCredential =
                              await FirebaseAuth.instance.signInWithEmailAndPassword(
                            email: emailController.text,
                            password: passwordController.text,
                          );

                          // Navigate to the home screen on successful login
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => HomeScreen(onLogout: () {})),
                          );
                        } on FirebaseAuthException catch (e) {
                          // Handle invalid credentials
                          print("Error: $e");
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                content: Container(
                                  padding: const EdgeInsets.symmetric(vertical: 1),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(
                                        FontAwesomeIcons.exclamationTriangle,
                                        color: Colors.orange,
                                      ),
                                      const SizedBox(height: 10.0),
                                      const Text("Sorry invalid login credentials!"),
                                      const SizedBox(height: 10.0),
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop(context); // Close the alert dialog
                                        },
                                        style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10.0),
                                            side: const BorderSide(color: Color(0xFF004751)),
                                          ),
                                        ),
                                        child: const Text("OK"),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        } finally {
                          setState(() {
                            isLoading = false;
                          });
                        }
                      },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ), backgroundColor: const Color(0xFF004751),
                  padding: const EdgeInsets.symmetric(horizontal: 155.0, vertical: 19.0),
                ),
                child: isLoading
                    ? const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      )
                    : const Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.white,
                        ),
                      ),
              ),
              const SizedBox(height: 20.0),
              const DividerWithText(text: 'OR'),
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      // Handle Google login
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ), backgroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                    ),
                    icon: const FaIcon(
                      FontAwesomeIcons.google,
                      color: Colors.black,
                    ),
                    label: const SizedBox.shrink(),
                  ),
                  const SizedBox(width: 10.0),
                  ElevatedButton.icon(
                    onPressed: () {
                      // Handle Apple login
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ), backgroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                    ),
                    icon: const FaIcon(
                      FontAwesomeIcons.apple,
                      color: Colors.white,
                    ),
                    label: const SizedBox.shrink(),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const RegisterScreen()),
                  );
                },
                child: const Text(
                  'Don\'t have an account? Register',
                  style: TextStyle(
                    color: Color(0xFF004751),
                    fontSize: 16.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DividerWithText extends StatelessWidget {
  final String text;

  const DividerWithText({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Divider(
            color: Colors.grey,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            text,
            style: const TextStyle(color: Colors.grey),
          ),
        ),
        const Expanded(
          child: Divider(
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
