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
    final available = <Coordinate>[];
    for (var i = 0; i < boardDimension; i++) {
      for (var j = 0; j < boardDimension; j++) {
        final coordinate = Coordinate(i, j);
        if (!_snake.contains(coordinate)) continue;
        available.add(coordinate);
      }
    }
    if (available.isEmpty) return;
    final head = _snake.first;
    final hardToReach = available.where((e) => e.dx != head.dx && e.dy != head.dy).toList(growable: false);
    final list = hardToReach.isEmpty ? available : hardToReach;
    _food = list[_random.nextInt(list.length)];
  }
}
