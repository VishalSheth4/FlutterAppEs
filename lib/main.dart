import 'package:flutter/material.dart';
import 'screens/login/login_screen.dart';
import 'screens/create_account/create_account_screen.dart';
import 'screens/forgot_password/forgot_password_screen.dart';
import 'screens/guest/guest_screen.dart';
import 'screens/add_item/product_page.dart'; 
 // Adjust the path as necessary
// Import your ProductPage file

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-Mart',
      debugShowCheckedModeBanner: false, // Remove the debug banner
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/create-account': (context) => const CreateAccountPage(),
        '/forgot-password': (context) => const ForgotPasswordScreen(),
        '/guest': (context) => const GuestScreen(),
        '/product': (context) => ProductPage(), // Add this route for ProductPage
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
