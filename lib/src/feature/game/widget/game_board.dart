import 'package:flutter/material.dart';

import '../model/game_board_size.dart';

/// {@template game_board}
/// GameBoard widget
/// {@endtemplate}
class GameBoard extends StatelessWidget {
  /// {@macro game_board}
  const GameBoard({required this.size, super.key});

  final GameBoardSize size;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: AspectRatio(
            aspectRatio: 1,
            child: LayoutBuilder(
              builder: (context, constraints) {
                final cellSize = constraints.biggest.shortestSide / size.dimension;
                return RepaintBoundary(
                  child: Stack(
                    children: <Positioned>[
                      Positioned.fill(
                        child: CustomPaint(
                          painter: _GameBoardPainter(cellSize: cellSize, dimension: size.dimension),
                          willChange: false,
                        ),
                      ),
                      const Positioned.fill(
                        child: CustomPaint(
                            //painter: _ObjectPainter(dimension: size.dimension),
                            //willChange: true,
                            //child: Placeholder(),
                            ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      );
} // GameBoard

/// {@template game_board}
/// _GameBoardPainter
/// {@endtemplate}
class _GameBoardPainter extends CustomPainter {
  /// {@macro main.game_board}
  const _GameBoardPainter({
    required this.cellSize,
    required this.dimension,
  });

  final double cellSize;
  final int dimension;

  @override
  void paint(Canvas canvas, Size size) {
    final padding = cellSize / 15;
    final rectSize = Size(cellSize - padding * 2, cellSize - padding * 2);
    final radius = Radius.circular(cellSize / 4);
    final rrect = RRect.fromRectAndRadius(Offset(padding, padding) & rectSize, radius);
    final paint = Paint()..color = const Color(0xFF78909c);
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
} // _GameBoard
