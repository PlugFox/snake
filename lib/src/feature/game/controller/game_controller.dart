import 'dart:async';

import 'package:flutter/foundation.dart';

import '../model/game_speed.dart';
import '../model/game_status.dart';

class GameController
    with ChangeNotifier, _GameStatusMixin, _SnakeControllerMixin, _FoodControllerMixin, _GameLoopMixin
    implements ValueListenable<GameStatus> {
  GameController({
    required GameSpeed speed,
  }) : _speed = speed;

  @override
  GameStatus get value => _$status;
  GameSpeed _speed;

  void start() {
    if (value.isStarted) return;
    _startGameLoop(_speed.duration);
  }

  void pause() => throw UnimplementedError();

  void resume() => throw UnimplementedError();

  void restart({GameSpeed? speed}) {
    stop();
    _speed = speed ?? _speed;
    start();
  }

  void stop() {
    if (!value.isStarted) return;
    _stopGameLoop();
  }

  @override
  void dispose() {
    stop();
    super.dispose();
  }
}

mixin _GameStatusMixin on ChangeNotifier {
  void _setStatus(GameStatus newStatus) {
    if (newStatus == _$status) return;
    _$status = newStatus;
    notifyListeners();
  }

  GameStatus _$status = GameStatus.stopped;
}

mixin _SnakeControllerMixin {
  void _updateSnakePosition() {}
  bool _gameOver() => false;
}

mixin _FoodControllerMixin on _SnakeControllerMixin {
  bool _foodIntersection() => false;
  void _feedSnake() {}
}

mixin _GameLoopMixin on _GameStatusMixin, _SnakeControllerMixin, _FoodControllerMixin {
  Timer? _ticker;

  void _startGameLoop(Duration duration) {
    _ticker = Timer.periodic(duration, (ticker) {
      _updateSnakePosition();
      while (_foodIntersection()) {
        _feedSnake();
      }
      if (_gameOver()) {
        _setStatus(GameStatus.gameOver);
        ticker.cancel();
      }
    });
    _setStatus(GameStatus.started);
  }

  void _stopGameLoop() {
    _ticker?.cancel();
    _ticker = null;
    _setStatus(GameStatus.stopped);
  }
}
