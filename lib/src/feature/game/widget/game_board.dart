import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_batteries/flutter_batteries.dart';

import '../model/coordinate.dart';
import '../model/snake.dart';
import 'game_control.dart';
import 'game_screen.dart';

/// {@template game_board}
/// GameBoard widget
/// {@endtemplate}
class GameBoard extends StatelessWidget {
  /// {@macro game_board}
  const GameBoard({super.key});

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (context, constraints) {
          final controller = GameScreen.maybeOf(context)!;
          return Padding(
            padding: EdgeInsets.all(8 + constraints.biggest.shortestSide / controller.boardSize.dimension),
            child: Center(
              child: AspectRatio(
                aspectRatio: 1,
                child: CustomPaint(
                  painter: _GameBoardPainter(dimension: controller.boardSize.dimension),
                  willChange: false,
                  child: RepaintBoundary(
                    child: GameControl(
                      child: CustomPaint(
                        foregroundPainter: _SnakePainter(
                          snakeListenable: controller.select<Snake>((listener) => listener.snake),
                          dimension: controller.boardSize.dimension,
                        ),
                        painter: _FoodPainter(
                          foodListenable: controller.select<Coordinate?>((listener) => listener.food),
                          dimension: controller.boardSize.dimension,
                        ),
                        willChange: true,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      );
} // GameBoard

/// {@template game_board_painter}
/// _GameBoardPainter
/// {@endtemplate}
class _GameBoardPainter extends CustomPainter {
  /// {@macro game_board_painter}
  const _GameBoardPainter({
    required this.dimension,
  });

  final int dimension;

  @override
  void paint(Canvas canvas, Size size) {
    final cellSize = size.shortestSide / dimension;
    final padding = cellSize / 10;
    final rectSize = Size(cellSize - padding * 2, cellSize - padding * 2);
    final radius = Radius.circular(cellSize / 4);
    final rrect = RRect.fromRectAndRadius(Offset(padding, padding) & rectSize, radius);
    final paint = Paint()..color = const Color(0xFF37474f);
    /*
    final paint = Paint()
      ..shader = ui.Gradient.linear(
        Offset(size.width / 5, 0),
        Offset(size.width * 4 / 5, size.height),
        [
          const Color(0xFF455a64),
          const Color(0xFF37474f),
        ],
      );
    */
    for (var i = 0; i < dimension; i++) {
      for (var j = 0; j < dimension; j++) {
        canvas.drawRRect(rrect.shift(Offset(i * cellSize, j * cellSize)), paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _GameBoardPainter oldDelegate) => dimension != oldDelegate.dimension;

  @override
  bool shouldRebuildSemantics(covariant _GameBoardPainter oldDelegate) => false;
} // _GameBoardPainter

/// {@template snake_painter}
/// _SnakePainter
/// {@endtemplate}
class _SnakePainter extends CustomPainter {
  /// {@macro snake_painter}
  _SnakePainter({
    required this.snakeListenable,
    required this.dimension,
  }) : super(repaint: snakeListenable);

  final ValueListenable<Snake> snakeListenable;
  final int dimension;

  @override
  void paint(Canvas canvas, Size size) {
    final cellSize = size.shortestSide / dimension;
    final snake = snakeListenable.value;
    if (snake.isEmpty) return;

    final padding = cellSize / 30;
    final rectSize = Size(cellSize - padding * 2, cellSize - padding * 2);
    final radius = Radius.circular(cellSize / 4);
    final rrect = RRect.fromRectAndRadius(Offset(padding, padding) & rectSize, radius);

    void drawSnake(int dx, int dy, Paint paint) =>
        canvas.drawRRect(rrect.shift(Offset(dx * cellSize, dy * cellSize)), paint);

    final errorPaint = Paint()..color = const Color(0xFFef5350);
    final headPaint = Paint()..color = const Color(0xFFeceff1);
    final tailPaint = Paint()..color = const Color(0xFFcfd8dc);

    final iterator = snake.iterator..moveNext();
    final head = iterator.current;

    while (iterator.moveNext()) {
      drawSnake(iterator.current.dx, iterator.current.dy, tailPaint);
    }

    if (max(head.dx, head.dy) >= dimension || min(head.dx, head.dy) < 0) {
      drawSnake(head.dx, head.dy, errorPaint);
    } else {
      drawSnake(head.dx, head.dy, headPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _SnakePainter oldDelegate) =>
      oldDelegate.snakeListenable.value.first != snakeListenable.value.first ||
      oldDelegate.snakeListenable.value.last != snakeListenable.value.last;

  @override
  bool shouldRebuildSemantics(covariant _SnakePainter oldDelegate) => false;
} // _SnakePainter

/// {@template food_painter}
/// _FoodPainter
/// {@endtemplate}
class _FoodPainter extends CustomPainter {
  /// {@macro food_painter}
  const _FoodPainter({
    required this.foodListenable,
    required this.dimension,
  }) : super(repaint: foodListenable);

  final ValueListenable<Coordinate?> foodListenable;
  final int dimension;

  @override
  void paint(Canvas canvas, Size size) {
    final cellSize = size.shortestSide / dimension;
    final food = foodListenable.value;
    if (food == null) return;

    final padding = cellSize / 20;
    final rectSize = Size(cellSize - padding * 2, cellSize - padding * 2);
    final radius = Radius.circular(cellSize / 4);
    final rrect = RRect.fromRectAndRadius(Offset(padding, padding) & rectSize, radius);

    final paint = Paint()..color = const Color(0xFF4caf50);

    canvas.drawRRect(rrect.shift(Offset(food.dx * cellSize, food.dy * cellSize)), paint);
  }

  @override
  bool shouldRepaint(covariant _FoodPainter oldDelegate) =>
      oldDelegate.foodListenable.value != foodListenable.value ||
      oldDelegate.foodListenable.value != foodListenable.value;

  @override
  bool shouldRebuildSemantics(_FoodPainter oldDelegate) => false;
} // _Food

