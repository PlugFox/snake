import 'package:flutter/material.dart';

/// {@template score_screen}
/// ScoreScreen widget
/// {@endtemplate}
class ScoreScreen extends StatelessWidget {
  /// {@macro score_screen}
  const ScoreScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Score'),
        ),
        body: const SafeArea(
          child: Placeholder(),
        ),
      );
} // ScoreScreen
