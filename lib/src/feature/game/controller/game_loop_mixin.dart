part of 'game_controller.dart';

mixin _GameLoopMixin on _GameStatusMixin, _SnakeControllerMixin, _FoodControllerMixin {
  Timer? _ticker;

  // TODO: sounds
  // Matiunin Mikhail <plugfox@gmail.com>, 17 July 2022

  void _startGameLoop(Duration duration, int boardDimension) {
    _createSnake(boardDimension);
    _spawnFood(boardDimension);
    _ticker = Timer.periodic(duration, (ticker) {
      _updateSnakePosition();
      if (_foodIntersection()) {
        _feedSnake();
      }
      if (_gameOver(boardDimension)) {
        _setStatus(GameStatus.gameOver);
        ticker.cancel();
      }
      _spawnFood(boardDimension);
      notifyListeners();
    });
    _setStatus(GameStatus.started);
  }

  void _stopGameLoop() {
    _ticker?.cancel();
    _ticker = null;
    _setStatus(GameStatus.stopped);
  }
}
