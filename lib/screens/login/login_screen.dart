import 'package:flutter/material.dart';

class Loginscreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'assets/e-t.jpeg', // Your background image path
              fit: BoxFit.cover,
            ),
          ),
          // Foreground content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  
                  
                  // Email or Mobile Field
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Email or mobile phone number',
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.8),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  
                  // Password Field
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Password',
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.8),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    obscureText: true,
                  ),
                  
                  // Forgot Password
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/forgot-password');
                      },
                      child: Text(
                        'Forgot Password?',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  
                  // Login Button
                  ElevatedButton(
                    onPressed: () {
                      // Handle login
                    },
                    child: Text('LOGIN'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,  // Button color
                      minimumSize: Size(double.infinity, 50),  // Full width button
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  
                  // Create Account
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/create-account');
                    },
                    child: Text(
                      'New in E-MART? Create an account',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 20),
                  
                  // Marketing Checkbox
                  CheckboxListTile(
                    title: Text(
                      'I agree to receive email marketing from E-MART',
                      style: TextStyle(color: Colors.white),
                    ),
                    value: true,
                    onChanged: (value) {
                      // Handle checkbox change
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                    activeColor: Colors.black,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
} 