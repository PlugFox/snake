/// {@template snake_direction}
/// SnakeDirection enumeration
/// {@endtemplate}
enum SnakeDirection with Comparable<SnakeDirection> {
  /// up
  up('up'),

  /// right
  right('right'),

  /// down
  down('down'),

  /// left
  left('left');

  /// {@macro snake_direction}
  const SnakeDirection(this.value);

  /// Creates a new instance of [SnakeDirection] from a given string.
  static SnakeDirection fromValue(String? value, {SnakeDirection? fallback}) {
    switch (value) {
      case 'up':
        return up;
      case 'right':
        return right;
      case 'down':
        return down;
      case 'left':
        return left;
      default:
        return fallback ?? (throw ArgumentError.value(value));
    }
  }

  /// Value of the enum
  final String value;

  /// Pattern matching
  T map<T>({
    required T Function() up,
    required T Function() right,
    required T Function() down,
    required T Function() left,
  }) {
    switch (this) {
      case SnakeDirection.up:
        return up();
      case SnakeDirection.right:
        return right();
      case SnakeDirection.down:
        return down();
      case SnakeDirection.left:
        return left();
    }
  }

  /// Pattern matching
  T maybeMap<T>({
    required T Function() orElse,
    T Function()? up,
    T Function()? right,
    T Function()? down,
    T Function()? left,
  }) =>
      map<T>(
        up: up ?? orElse,
        right: right ?? orElse,
        down: down ?? orElse,
        left: left ?? orElse,
      );

  /// Pattern matching
  T? maybeMapOrNull<T>({
    T Function()? up,
    T Function()? right,
    T Function()? down,
    T Function()? left,
  }) =>
      maybeMap<T?>(
        orElse: () => null,
        up: up,
        right: right,
        down: down,
        left: left,
      );

  @override
  int compareTo(SnakeDirection other) => index.compareTo(other.index);

  @override
  String toString() => value;
}
