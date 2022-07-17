import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

import '../model/coordinate.dart';
import '../model/game_board_size.dart';
import '../model/game_speed.dart';
import '../model/game_status.dart';
import '../model/snake.dart';
import '../model/snake_direction.dart';

part 'food_controller_mixin.dart';
part 'game_loop_mixin.dart';
part 'game_status_mixin.dart';
part 'snake_controller_mixin.dart';

abstract class IGameListenable implements Listenable {
  GameSpeed get speed;
  GameBoardSize get boardSize;
  GameStatus get status;
  Snake get snake;
  Coordinate? get food;
}

abstract class GameController implements IGameListenable {
  void start();
  bool setDirection(SnakeDirection direction);
  void pause();
  void resume();
  void restart({GameSpeed? speed, GameBoardSize? boardSize});
  void stop();
  void dispose();
}

class GameControllerImpl extends GameController
    with ChangeNotifier, _GameStatusMixin, _SnakeControllerMixin, _FoodControllerMixin, _GameLoopMixin {
  GameControllerImpl({
    required GameSpeed speed,
    required GameBoardSize boardSize,
  })  : _speed = speed,
        _boardSize = boardSize;

  @override
  GameStatus get status => _$status;

  @override
  GameSpeed get speed => _speed;
  GameSpeed _speed;

  @override
  GameBoardSize get boardSize => _boardSize;
  GameBoardSize _boardSize;

  @override
  Snake get snake => _snake;

  @override
  Coordinate? get food => _food;

  @override
  void start() {
    if (status.isStarted) return;
    _startGameLoop(_speed.duration, _boardSize.dimension);
  }

  @override
  void pause() => throw UnimplementedError();

  @override
  void resume() => throw UnimplementedError();

  @override
  void restart({GameSpeed? speed, GameBoardSize? boardSize}) {
    stop();
    _speed = speed ?? _speed;
    _boardSize = boardSize ?? _boardSize;
    start();
  }

  @override
  void stop() {
    if (!status.isStarted) return;
    _stopGameLoop();
  }

  @override
  void dispose() {
    stop();
    super.dispose();
  }
}
