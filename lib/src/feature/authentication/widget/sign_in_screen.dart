import 'package:flutter/material.dart';

/// {@template sign_in_screen}
/// SignInScreen widget
/// {@endtemplate}
class SignInScreen extends StatelessWidget {
  /// {@macro sign_in_screen}
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('SignIn'),
        ),
        body: const Placeholder(),
      );
} // SignInScreen
