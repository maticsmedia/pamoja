import 'package:flutter/material.dart';

class OTPScreen extends StatelessWidget {
  List<TextEditingController> otpControllers = List.generate(4, (index) => TextEditingController());
  List<FocusNode> focusNodes = List.generate(4, (index) => FocusNode());

  OTPScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'OTP Verification',
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
              Image.asset(
                'assets/logo.png',
                height: 150.0,
                width: 150.0,
              ),
              const SizedBox(height: 30.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                  4,
                      (index) => buildOtpBox(context, index),
                ),
              ),
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      // Implement resend OTP logic here
                    },
                    child: const Text(
                      'Resend OTP',
                      style: TextStyle(color: Color(0xFF004751)),
                    ),
                  ),
                  const Text(
                    'OTP Time: 00:59',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  // Implement proceed logic here
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 150.0, vertical: 19.0),
                ),
                child: const Text('Proceed'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildOtpBox(BuildContext context, int index) {
    return Container(
      width: 50.0,
      height: 50.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: Colors.black,
          width: 2.0,
        ),
      ),
      child: TextField(
        controller: otpControllers[index],
        focusNode: focusNodes[index],
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 24.0, letterSpacing: 20.0),
        decoration: const InputDecoration(
          border: InputBorder.none,
        ),
        onChanged: (value) {
          if (value.length == 1) {
            focusNodes[index].unfocus();
            if (index < 3) {
              FocusScope.of(context).requestFocus(focusNodes[index + 1]);
            }
          }
        },
      ),
    );
  }
}
