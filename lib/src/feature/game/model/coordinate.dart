import 'package:meta/meta.dart';

/// {@template coordinate}
/// Coordinate entity
/// {@endtemplate}
@immutable
// ignore: prefer_mixin
class Coordinate {
  /// {@macro coordinate}
  const Coordinate(
    this.dx,
    this.dy,
  );

  final int dx;

  final int dy;

  /// Generate Class from Map<String, Object?>
  factory Coordinate.fromJson(Map<String, Object?> json) => Coordinate(
        json['x']! as int,
        json['y']! as int,
      );

  /// Generate Map<String, Object?> from class
  Map<String, Object?> toJson() => <String, Object?>{
        'x': dx,
        'y': dy,
      };

  /// Create a copy of this object with the given values.
  @useResult
  Coordinate copyWith({
    int? dx,
    int? dy,
  }) =>
      Coordinate(
        dx ?? this.dx,
        dy ?? this.dy,
      );

  @override
  int get hashCode => dx * 1000 + dy;

  @override
  bool operator ==(Object other) => identical(this, other) || (other is Coordinate && dx == other.dx && dy == other.dy);

  @override
  String toString() => 'Coordinate{dx: $dx, dy: $dy}';
} // Coordinate
