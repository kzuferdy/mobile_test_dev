import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_test_dev/logic/login/login_bloc.dart';
import 'package:mobile_test_dev/pages/dashboard_page.dart'; // Pastikan import benar

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthAuthenticated) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const DashboardScreen()),
            );
          }
          if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage)),
            );
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Logo / Header (optional)
                      const Text(
                        'Welcome Back!',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent,
                        ),
                      ),
                      const SizedBox(height: 40),

                      // Input Username
                      _buildTextField(
                        controller: _usernameController,
                        label: 'Username',
                        obscureText: false,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Username cannot be empty';
                          }
                          return null;
                        },
                      ),
                      // Input Password
                      _buildTextField(
                        controller: _passwordController,
                        label: 'Password',
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),

                      // Button Login
                      _buildLoginButton(context),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // Widget TextField untuk input username dan password
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required bool obscureText,
    required String? Function(String?) validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 1.0),
          ),
        ),
        obscureText: obscureText,
        validator: validator,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }

  // Button Login
  Widget _buildLoginButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          context.read<AuthBloc>().add(
            LoginSubmitted(
              username: _usernameController.text,
              password: _passwordController.text,
            ),
          );
        }
      },
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 50), 
        backgroundColor: Colors.blueAccent, // Custom color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      child: const Text(
        'Login',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }
}
