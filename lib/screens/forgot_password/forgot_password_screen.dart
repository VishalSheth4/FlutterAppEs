import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Enter your email or mobile number to reset your password'),
              TextField(
                decoration: InputDecoration(labelText: 'Email or mobile number'),
              ),
              ElevatedButton(
                onPressed: () {
                  // Handle password reset
                },
                child: Text('RESET PASSWORD'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
