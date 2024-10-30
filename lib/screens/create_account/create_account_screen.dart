import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/login/login_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CreateAccountPage extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  void createAccount(BuildContext context) async {
    final name = nameController.text;
    final email = emailController.text;
    final password = passwordController.text;
    // ignore: unused_local_variable
    final confirmPassword = confirmPasswordController.text;

    print('Account creation initiated 1.1');
    print('Account creation initiated ${name} , ${email} , ${password}');

    final response = await http
        .post(
          Uri.parse('http://192.168.1.6:3001/create-account'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'name': name,
            'email': email,
            'password': password,
          }),
        )
        .timeout(const Duration(seconds: 5));

    print('Account creation initiated 1.2');
    if (response.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Account created successfully")),
      );
      Navigator.pop(context);
    } else {
      final errorResponse = jsonDecode(response.body);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content:
                Text(errorResponse['message'] ?? 'Failed to create account')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 40),
                Text(
                  'Create Account',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 30),
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: 'Your Name',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person),
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email),
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.lock),
                  ),
                  obscureText: true,
                ),
                SizedBox(height: 20),
                TextField(
                  controller: confirmPasswordController,
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.lock),
                  ),
                  obscureText: true,
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    print('Account creation initiated');
                    createAccount(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding:
                        EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                    textStyle: TextStyle(fontSize: 16),
                  ),
                  child: Text('CREATE ACCOUNT'),
                ),
                SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Loginscreen()),
                    );
                  },
                  child: Text(
                    'Already have an account? Login',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
