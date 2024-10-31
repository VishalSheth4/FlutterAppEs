import 'package:flutter/material.dart';
import 'screens/login/login_screen.dart';
import 'screens/create_account/create_account_screen.dart';
import 'screens/forgot_password/forgot_password_screen.dart';
import 'screens/guest/guest_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-Mart',
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/create-account': (context) => const CreateAccountPage(),
        '/forgot-password': (context) => const ForgotPasswordScreen(),
        '/guest': (context) => const GuestScreen(),
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
