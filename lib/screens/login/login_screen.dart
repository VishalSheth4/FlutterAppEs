import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isMarketingChecked = false;

  void _login(BuildContext context) {
    if (_formKey.currentState?.validate() ?? false) {
      // Show success message in green
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Successfully logged in'),
          backgroundColor: Colors.green,
        ),
      );

      // Navigate to ProductPage after showing the success message
      Future.delayed(Duration(seconds: 1), () {
        Navigator.pushNamed(context, '/product');
      });
    }
  }

  void _loginWithGoogle() {
    // Implement Google login logic here
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Log in with Google pressed'),
      ),
    );
  }

  void _loginWithPhoneNumber() {
    // Implement Phone number login logic here
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Log in with Phone Number pressed'),
      ),
    );
  }

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
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Email or Mobile Field
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'Email or mobile phone number',
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.8),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      autofillHints: [AutofillHints.email], // Enable autofill
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email or phone number';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    
                    // Password Field
                    TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.8),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      obscureText: true,
                      textInputAction: TextInputAction.done,
                      autofillHints: [AutofillHints.password], // Enable autofill
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),

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
                        _login(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,  // Button color
                        minimumSize: Size(double.infinity, 50),  // Full width button
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: Text('LOGIN'),
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
                      value: _isMarketingChecked,
                      onChanged: (value) {
                        setState(() {
                          _isMarketingChecked = value ?? false;
                        });
                      },
                      controlAffinity: ListTileControlAffinity.leading,
                      activeColor: Colors.black,
                    ),
                    SizedBox(height: 20),

                    // Login with Google Button
                    ElevatedButton.icon(
                      onPressed: _loginWithGoogle,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        minimumSize: Size(double.infinity, 50), // Full width button
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                        icon: Icon(Icons.g_mobiledata,  color: Colors.black),
                      label: Text('Log in with Google', style: TextStyle(color: Colors.black)),
                    ),
                    SizedBox(height: 10),

                    // Login with Phone Number Button
                    ElevatedButton.icon(
                      onPressed: _loginWithPhoneNumber,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        minimumSize: Size(double.infinity, 50), // Full width button
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      icon: Icon(Icons.phone, color: Colors.black),
                      label: Text('Log in with Phone Number', style: TextStyle(color: Colors.black)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
