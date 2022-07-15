import 'package:flutter/material.dart';

import '../../../common/router/app_router.dart';
import '../model/game_board_size.dart';
import '../model/game_speed.dart';

/// {@template game_screen}
/// GameScreen widget
/// {@endtemplate}
class GameScreen extends StatelessWidget {
  /// {@macro game_screen}
  const GameScreen({
    required this.size,
    required this.speed,
    super.key,
  });

  final GameBoardSize size;
  final GameSpeed speed;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Game'),
        ),
        body: Center(
          child: TextButton.icon(
            onPressed: () => AppRouter.instance().goMenu(),
            icon: const Icon(Icons.home),
            label: const Text('Go back to menu'),
          ),
        ),
      );
} // GameScreen
