/// {@template game_board_size}
/// GameBoardSize enumeration
/// {@endtemplate}
enum GameBoardSize with Comparable<GameBoardSize> {
  /// small
  small('small'),

  /// medium
  medium('medium'),

  /// large
  large('large');

  /// {@macro game_board_size}
  const GameBoardSize(this.value);

  /// Creates a new instance of [GameBoardSize] from a given string.
  static GameBoardSize fromValue(String? value, {GameBoardSize? fallback}) {
    switch (value) {
      case 'small':
        return small;
      case 'medium':
        return medium;
      case 'large':
        return large;
      default:
        return fallback ?? (throw ArgumentError.value(value));
    }
  }

  /// Value of the enum
  final String value;

  int get dimension => map<int>(
        small: () => 12,
        medium: () => 24,
        large: () => 48,
      );

  /// Pattern matching
  T map<T>({
    required T Function() small,
    required T Function() medium,
    required T Function() large,
  }) {
    switch (this) {
      case GameBoardSize.small:
        return small();
      case GameBoardSize.medium:
        return medium();
      case GameBoardSize.large:
        return large();
    }
  }

  /// Pattern matching
  T maybeMap<T>({
    required T Function() orElse,
    T Function()? small,
    T Function()? medium,
    T Function()? large,
  }) =>
      map<T>(
        small: small ?? orElse,
        medium: medium ?? orElse,
        large: large ?? orElse,
      );

  /// Pattern matching
  T? maybeMapOrNull<T>({
    T Function()? small,
    T Function()? medium,
    T Function()? large,
  }) =>
      maybeMap<T?>(
        orElse: () => null,
        small: small,
        medium: medium,
        large: large,
      );

  @override
  int compareTo(GameBoardSize other) => index.compareTo(other.index);

  @override
  String toString() => value;
}
