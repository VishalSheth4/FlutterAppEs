import 'package:flutter/material.dart';

class GuestScreen extends StatelessWidget {
  const GuestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ElevatedButton(
            onPressed: () {
              // Handle continue as guest
            },
            child: Text('CONTINUE AS GUEST'),
          ),
        ),
      ),
    );
  }
}
