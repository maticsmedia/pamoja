import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pamoja/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController createPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  bool _isPasswordVisible = false;

  Future<void> _register() async {
    if (_validateFields()) {
      // Perform registration logic here
      try {
        UserCredential userCredential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: createPasswordController.text,
        );

        // Registration successful, navigate to login screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          _showErrorDialog('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          _showErrorDialog('The account already exists for that email.');
        }
      } catch (e) {
        _showErrorDialog(e.toString());
      }
    }
  }

  bool _validateFields() {
    if (fullNameController.text.isEmpty ||
        emailController.text.isEmpty ||
        phoneNumberController.text.isEmpty ||
        createPasswordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty) {
      _showAlertDialog('Error', 'Please enter all information.');
      return false;
    } else if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(fullNameController.text)) {
      _showAlertDialog('Error', 'Please enter a valid full name.');
      return false;
    } else if (!RegExp(r'^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$').hasMatch(emailController.text)) {
      _showAlertDialog('Error', 'Please enter a valid email address.');
      return false;
    } else if (!RegExp(r'^\d{10}$').hasMatch(phoneNumberController.text)) {
      _showAlertDialog('Error', 'Please enter a valid phone number.');
      return false;
    } else if (createPasswordController.text.length < 6) {
      _showAlertDialog('Error', 'Password must be at least 6 characters.');
      return false;
    } else if (createPasswordController.text != confirmPasswordController.text) {
      _showAlertDialog('Error', 'Passwords do not match.');
      return false;
    }

    return true;
  }

  void _showErrorDialog(String errorMessage) {
    _showAlertDialog('Error', errorMessage);
  }

  void _showAlertDialog(String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              const Icon(Icons.sentiment_dissatisfied, color: Color(0xFF004751)),
              const SizedBox(width: 10),
              Text(title, style: const TextStyle(color: Color(0xFF004751))),
            ],
          ),
          content: Text(content, style: const TextStyle(color: Color(0xFF004751))),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK', style: TextStyle(color: Color(0xFF004751))),
            ),
          ],
        );
      },
    );
  }

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
      body: SingleChildScrollView(
        child: Padding(
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
              TextField(
                controller: fullNameController,
                style: const TextStyle(fontSize: 16.0),
                decoration: InputDecoration(
                  labelText: 'Full Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 19.0),
                ),
              ),
              const SizedBox(height: 10.0),
              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                style: const TextStyle(fontSize: 16.0),
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 19.0),
                ),
              ),
              const SizedBox(height: 10.0),
              TextField(
                controller: phoneNumberController,
                keyboardType: TextInputType.phone,
                style: const TextStyle(fontSize: 16.0),
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 19.0),
                ),
              ),
              const SizedBox(height: 10.0),
              TextField(
                controller: createPasswordController,
                obscureText: !_isPasswordVisible,
                style: const TextStyle(fontSize: 16.0),
                decoration: InputDecoration(
                  labelText: 'Create Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 19.0),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              TextField(
                controller: confirmPasswordController,
                obscureText: !_isPasswordVisible,
                style: const TextStyle(fontSize: 16.0),
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 19.0),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: _register,
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 150.0, vertical: 19.0),
                  backgroundColor: const Color(0xFF004751),
                ),
                child: const Text('Register', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
