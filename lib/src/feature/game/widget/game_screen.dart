import 'package:flutter/material.dart';

import '../../../common/router/app_router.dart';
import '../model/game_board_size.dart';
import '../model/game_speed.dart';
import 'game_board.dart';

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
        body: SafeArea(
          child: OrientationBuilder(
            builder: (context, orientation) => Flex(
              direction: orientation == Orientation.portrait ? Axis.vertical : Axis.horizontal,
              children: <Widget>[
                Expanded(child: GameBoard(size: size)),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(48),
                    child: CircleAvatar(
                      radius: 32,
                      backgroundColor: Theme.of(context).primaryColor,
                      foregroundColor: Theme.of(context).scaffoldBackgroundColor,
                      child: IconButton(
                        icon: const Icon(Icons.home),
                        onPressed: () => AppRouter.instance().goMenu(),
                        tooltip: 'Go back to menu',
                        iconSize: 48,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
} // GameScreen
