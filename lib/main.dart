import 'package:flutter/material.dart';
import 'screens/login/login_screen.dart';
import 'screens/create_account/create_account_screen.dart';
import 'screens/forgot_password/forgot_password_screen.dart';
import 'screens/guest/guest_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-Mart',
      initialRoute: '/login',
      routes: {
        '/login': (context) => Loginscreen(),
        '/create-account': (context) => CreateAccountPage(),
        '/forgot-password': (context) => ForgotPasswordScreen(),
        '/guest': (context) => GuestScreen(),
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
} 