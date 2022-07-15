/// {@template game_board_size}
/// GameBoardSize enumeration
/// {@endtemplate}
enum GameBoardSize with Comparable<GameBoardSize> {
  /// small
  small('small'),

  /// medium
  medium('medium'),

  /// hardcore
  hardcore('hardcore');

  /// {@macro game_board_size}
  const GameBoardSize(this.value);

  /// Creates a new instance of [GameBoardSize] from a given string.
  static GameBoardSize fromValue(String? value, {GameBoardSize? fallback}) {
    switch (value) {
      case 'small':
        return small;
      case 'medium':
        return medium;
      case 'hardcore':
        return hardcore;
      default:
        return fallback ?? (throw ArgumentError.value(value));
    }
  }

  /// Value of the enum
  final String value;

  /// Pattern matching
  T map<T>({
    required T Function() small,
    required T Function() medium,
    required T Function() hardcore,
  }) {
    switch (this) {
      case GameBoardSize.small:
        return small();
      case GameBoardSize.medium:
        return medium();
      case GameBoardSize.hardcore:
        return hardcore();
    }
  }

  /// Pattern matching
  T maybeMap<T>({
    required T Function() orElse,
    T Function()? small,
    T Function()? medium,
    T Function()? hardcore,
  }) =>
      map<T>(
        small: small ?? orElse,
        medium: medium ?? orElse,
        hardcore: hardcore ?? orElse,
      );

  /// Pattern matching
  T? maybeMapOrNull<T>({
    T Function()? small,
    T Function()? medium,
    T Function()? hardcore,
  }) =>
      maybeMap<T?>(
        orElse: () => null,
        small: small,
        medium: medium,
        hardcore: hardcore,
      );

  @override
  int compareTo(GameBoardSize other) => index.compareTo(other.index);

  @override
  String toString() => value;
}
