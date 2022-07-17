import 'dart:async';

import 'package:flutter/material.dart';

import '../../../common/router/app_router.dart';
import '../controller/game_controller.dart';
import '../model/game_board_size.dart';
import '../model/game_speed.dart';
import '../model/game_status.dart';
import 'game_board.dart';

/// {@template game_screen}
/// GameScreen widget
/// {@endtemplate}
class GameScreen extends StatefulWidget {
  /// {@macro game_screen}
  const GameScreen({
    required this.size,
    required this.speed,
    super.key,
  });

  final GameBoardSize size;
  final GameSpeed speed;

  /// The Game Controller from the closest instance of the GameScreen
  /// that encloses the given context, if any.
  static GameController? maybeOf(BuildContext context) =>
      context.findAncestorStateOfType<_GameScreenState>()?._gameController;

  @override
  State<GameScreen> createState() => _GameScreenState();
} // GameScreen

class _GameScreenState extends State<GameScreen> {
  late final GameController _gameController;

  @override
  void initState() {
    super.initState();
    _gameController = GameControllerImpl(
      boardSize: widget.size,
      speed: widget.speed,
    );
    scheduleMicrotask(_gameController.start);
    _gameController.addListener(_onGameChanged);
    // TODO: save and restore progress
    // Matiunin Mikhail <plugfox@gmail.com>, 17 July 2022
  }

  @override
  void didUpdateWidget(covariant GameScreen oldWidget) {
    if (oldWidget.size != widget.size || oldWidget.speed != widget.speed) {
      _gameController.restart(speed: widget.speed, boardSize: widget.size);
    }
    super.didUpdateWidget(oldWidget);
  }

  void _onGameChanged() {
    if (_gameController.status == GameStatus.gameOver) {
      // TODO: Try again with score
      // Matiunin Mikhail <plugfox@gmail.com>, 17 July 2022
      _gameController.restart();
    }
  }

  @override
  void dispose() {
    _gameController.dispose();
    super.dispose();
  }

  // TODO: Additional information
  // Matiunin Mikhail <plugfox@gmail.com>, 17 July 2022

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: OrientationBuilder(
            builder: (context, orientation) => Flex(
              direction: orientation == Orientation.portrait ? Axis.vertical : Axis.horizontal,
              children: <Widget>[
                const Expanded(child: GameBoard()),
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
} // _GameScreenState
