part of 'game_controller.dart';

mixin _FoodControllerMixin on _SnakeControllerMixin {
  Coordinate? _food;
  final _random = Random();

  bool _foodIntersection() => _snake.first == _food;

  void _feedSnake() {
    _food = null;
    final tail = _snake.last;
    final newTail = _direction.map<Coordinate>(
      up: () => Coordinate(tail.dx, tail.dy + 1),
      right: () => Coordinate(tail.dx - 1, tail.dy),
      down: () => Coordinate(tail.dx, tail.dy - 1),
      left: () => Coordinate(tail.dx + 1, tail.dy),
    );
    _snake = Snake(
      <Coordinate>[
        ..._snake,
        newTail,
      ],
    );
  }

  void _spawnFood(int boardDimension) {
    if (_food != null) return;
    Coordinate? newFood;
    var attempts = 1000;
    do {
      if (attempts < 0) return;
      newFood = Coordinate(_random.nextInt(boardDimension), _random.nextInt(boardDimension));
      attempts--;
    } while (_snake.contains(newFood));
    _food = newFood;
  }
}
