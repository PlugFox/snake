part of 'game_controller.dart';

mixin _SnakeControllerMixin on GameController {
  Snake _snake = const Snake.empty();
  SnakeDirection _direction = SnakeDirection.up;

  @override
  // ignore: use_setters_to_change_properties
  bool setDirection(SnakeDirection direction) {
    if (snake.length > 1) {
      final head = snake[0];
      final tail = snake[1];
      if (head.dx < tail.dx && direction == SnakeDirection.right) {
        return false;
      } else if (head.dx > tail.dx && direction == SnakeDirection.left) {
        return false;
      } else if (head.dy < tail.dy && direction == SnakeDirection.down) {
        return false;
      } else if (head.dy > tail.dy && direction == SnakeDirection.up) {
        return false;
      }
    }

    _direction = direction;
    return true;
  }

  void _createSnake(int boardDimension) {
    final center = (boardDimension / 2).ceil();
    _snake = Snake(<Coordinate>[Coordinate(center, center)]);
  }

  void _updateSnakePosition() {
    final length = _snake.length;
    final head = _snake.first;
    final newHead = _direction.map<Coordinate>(
      up: () => Coordinate(head.dx, head.dy - 1),
      right: () => Coordinate(head.dx + 1, head.dy),
      down: () => Coordinate(head.dx, head.dy + 1),
      left: () => Coordinate(head.dx - 1, head.dy),
    );
    _snake = Snake(
      <Coordinate>[
        newHead,
        ..._snake.take(length - 1),
      ],
    );
  }

  @useResult
  bool _gameOver(int boardDimension) {
    final head = _snake.first;
    final borderIntersection = max(head.dx, head.dy) >= boardDimension || min(head.dx, head.dy) < 0;
    final snakeIntersection = _snake.skip(1).contains(head);
    return borderIntersection || snakeIntersection;
  }
}
