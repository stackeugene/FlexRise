import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/auth/auth_bloc.dart';
import '../bloc/auth/auth_event.dart';
import '../routes/app_routes.dart';

class SignInScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, bool>(
      listener: (context, state) {
        if (state) {
          Navigator.pushReplacementNamed(context, AppRoutes.calendar);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('FlexRise - Sign In'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  context.read<AuthBloc>().add(
                        SignInRequested(
                          email: _emailController.text,
                          password: _passwordController.text,
                        ),
                      );
                },
                child: const Text('Sign In'),
              ),
              TextButton(
                onPressed: () {
                  // Navigate to Sign-Up screen (placeholder for now)
                },
                child: const Text('Sign Up'),
              ),
              TextButton(
                onPressed: () {
                  // Handle "Forgot Password" (placeholder)
                },
                child: const Text('Forgot Password?'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}