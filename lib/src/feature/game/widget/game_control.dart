import 'dart:async';

import 'package:flutter/material.dart';

import '../../../common/widget/sizer.dart';
import '../controller/game_controller.dart';
import '../model/snake_direction.dart';
import 'game_screen.dart';

/// {@template game_control}
/// GameControl widget
/// {@endtemplate}
class GameControl extends StatefulWidget {
  /// {@macro game_control}
  const GameControl({
    required this.child,
    super.key,
  });

  /// The widget below this widget in the tree.
  final Widget child;

  @override
  State<GameControl> createState() => _GameControlState();
} // GameControl

/// State for widget GameControl
class _GameControlState extends State<GameControl>
    with _GameControllerMixin, _PointerMixin, _KeyboardMixin, _AutoAimMixin {
  @override
  Widget build(BuildContext context) => Sizer(
        onSizeChanged: (size) {
          _size = size;
          _isTop = _isInTopTriangle(size);
          _isRight = _isInRightTriangle(size);
          _isBottom = _isInBottomTriangle(size);
          _isLeft = _isInLeftTriangle(size);
        },
        child: Listener(
          onPointerHover: _onHover,
          onPointerMove: _onHover,
          child: widget.child,
        ),
      );
} // _GameControlState

mixin _GameControllerMixin on State<GameControl> {
  late Size _size = Size.zero;
  late final GameController _controller;

  @override
  void initState() {
    _controller = GameScreen.maybeOf(context)!;
    super.initState();
  }
}

mixin _PointerMixin on State<GameControl>, _GameControllerMixin {
  bool petalControl = false;
  bool swipeControl = false;
  bool pointerControl = true;

  /* Controll with four triangles */
  bool Function(Offset point) _isTop = (_) => false;
  bool Function(Offset point) _isRight = (_) => false;
  bool Function(Offset point) _isBottom = (_) => false;
  bool Function(Offset point) _isLeft = (_) => false;

  void _onHover(PointerEvent event) {
    if (petalControl) {
      final position = event.localPosition;
      if (_isTop(position)) {
        _controller.setDirection(SnakeDirection.up);
      } else if (_isRight(position)) {
        _controller.setDirection(SnakeDirection.right);
      } else if (_isBottom(position)) {
        _controller.setDirection(SnakeDirection.down);
      } else if (_isLeft(position)) {
        _controller.setDirection(SnakeDirection.left);
      }
    } else if (swipeControl) {
    } else if (pointerControl) {
      final pointerX = event.localPosition.dx * _controller.boardSize.dimension ~/ _size.width;
      final pointerY = event.localPosition.dy * _controller.boardSize.dimension ~/ _size.height;
      final head = _controller.snake.first;
      final width = head.dx - pointerX;
      final height = head.dy - pointerY;
      if (width.abs() > height.abs()) {
        _controller.setDirection(width > 0 ? SnakeDirection.left : SnakeDirection.right);
      } else {
        _controller.setDirection(height > 0 ? SnakeDirection.up : SnakeDirection.down);
      }
    }
  }

  bool _isInTriangle(Offset vertex1, Offset vertex2, Offset vertex3, Offset point) =>
      {
        ((vertex1.dx - point.dx) * (vertex2.dy - vertex1.dy) - (vertex2.dx - vertex1.dx) * (vertex1.dy - point.dy))
            .sign,
        ((vertex2.dx - point.dx) * (vertex3.dy - vertex2.dy) - (vertex3.dx - vertex2.dx) * (vertex2.dy - point.dy))
            .sign,
        ((vertex3.dx - point.dx) * (vertex1.dy - vertex3.dy) - (vertex1.dx - vertex3.dx) * (vertex3.dy - point.dy))
            .sign,
      }.length ==
      1;

  bool Function(Offset point) _isInTopTriangle(Size size) => (point) => _isInTriangle(
        Offset.zero,
        Offset(size.width / 2, size.height / 2),
        Offset(size.width, 0),
        point,
      );

  bool Function(Offset point) _isInRightTriangle(Size size) => (point) => _isInTriangle(
        Offset(size.width, 0),
        Offset(size.width / 2, size.height / 2),
        Offset(size.width, size.height),
        point,
      );

  bool Function(Offset point) _isInBottomTriangle(Size size) => (point) => _isInTriangle(
        Offset(0, size.height),
        Offset(size.width / 2, size.height / 2),
        Offset(size.width, size.height),
        point,
      );

  bool Function(Offset point) _isInLeftTriangle(Size size) => (point) => _isInTriangle(
        Offset.zero,
        Offset(size.width / 2, size.height / 2),
        Offset(0, size.height),
        point,
      );
}

mixin _KeyboardMixin on State<GameControl>, _GameControllerMixin {
  //final FocusNode _focusNode = FocusNode();

  /* 
  void _onKey(KeyboardKey key) {
    if (key == PhysicalKeyboardKey.arrowUp || key == LogicalKeyboardKey.arrowUp) {
      _controller.setDirection(SnakeDirection.up);
    } else if (key == PhysicalKeyboardKey.arrowRight || key == LogicalKeyboardKey.arrowRight) {
      _controller.setDirection(SnakeDirection.right);
    } else if (key == PhysicalKeyboardKey.arrowDown || key == LogicalKeyboardKey.arrowDown) {
      _controller.setDirection(SnakeDirection.down);
    } else if (key == PhysicalKeyboardKey.arrowLeft || key == LogicalKeyboardKey.arrowLeft) {
      _controller.setDirection(SnakeDirection.left);
    }
  }
  */
}

mixin _AutoAimMixin on State<GameControl>, _GameControllerMixin {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    if (const bool.fromEnvironment('auto-aim', defaultValue: false)) {
      _timer = Timer.periodic(const Duration(milliseconds: 150), (_) => _autoAim());
    }
  }

  void _autoAim() {
    final head = _controller.snake.first;
    final food = _controller.food;
    if (food == null) return;
    final width = head.dx - food.dx;
    final height = head.dy - food.dy;
    if (width.abs() > height.abs()) {
      if (!_controller.setDirection(width > 0 ? SnakeDirection.left : SnakeDirection.right)) {
        _controller.setDirection(SnakeDirection.up);
      }
    } else {
      if (!_controller.setDirection(height > 0 ? SnakeDirection.up : SnakeDirection.down)) {
        _controller.setDirection(SnakeDirection.left);
      }
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
