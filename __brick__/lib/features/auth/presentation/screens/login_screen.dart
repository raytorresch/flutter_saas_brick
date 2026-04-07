import 'package:{{projectName}}/core/core.dart';
import 'package:flutter/material.dart';

/// Placeholder login screen.
/// Replace with your real authentication UI.
///
/// To authenticate:
///   await getIt<AuthNotifier>().setAuthenticated(token);
///
/// To logout from anywhere:
///   await getIt<AuthNotifier>().logout();
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Welcome',
                style: context.headlineLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 48),
              ElevatedButton(
                onPressed: () async {
                  // TODO: replace with real login flow
                  // On success call:
                  await getIt<AuthNotifier>().setAuthenticated('demo_token');
                },
                child: const Text('Sign in'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
