/// {@template game_speed}
/// GameSpeed enumeration
/// {@endtemplate}
enum GameSpeed with Comparable<GameSpeed> {
  /// slow
  slow('slow'),

  /// medium
  medium('medium'),

  /// fast
  fast('fast');

  /// {@macro game_speed}
  const GameSpeed(this.value);

  /// Creates a new instance of [GameSpeed] from a given string.
  static GameSpeed fromValue(String? value, {GameSpeed? fallback}) {
    switch (value) {
      case 'slow':
        return slow;
      case 'medium':
        return medium;
      case 'fast':
        return fast;
      default:
        return fallback ?? (throw ArgumentError.value(value));
    }
  }

  /// Value of the enum
  final String value;

  Duration get duration => map<Duration>(
        slow: () => const Duration(milliseconds: 500),
        medium: () => const Duration(milliseconds: 250),
        fast: () => const Duration(milliseconds: 150),
      );

  /// Pattern matching
  T map<T>({
    required T Function() slow,
    required T Function() medium,
    required T Function() fast,
  }) {
    switch (this) {
      case GameSpeed.slow:
        return slow();
      case GameSpeed.medium:
        return medium();
      case GameSpeed.fast:
        return fast();
    }
  }

  /// Pattern matching
  T maybeMap<T>({
    required T Function() orElse,
    T Function()? slow,
    T Function()? medium,
    T Function()? fast,
  }) =>
      map<T>(
        slow: slow ?? orElse,
        medium: medium ?? orElse,
        fast: fast ?? orElse,
      );

  /// Pattern matching
  T? maybeMapOrNull<T>({
    T Function()? slow,
    T Function()? medium,
    T Function()? fast,
  }) =>
      maybeMap<T?>(
        orElse: () => null,
        slow: slow,
        medium: medium,
        fast: fast,
      );

  @override
  int compareTo(GameSpeed other) => index.compareTo(other.index);

  @override
  String toString() => value;
}
