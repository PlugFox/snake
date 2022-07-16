/// {@template game_status}
/// GameStatus enumeration
/// {@endtemplate}
enum GameStatus with Comparable<GameStatus> {
  /// started
  started('started'),

  /// stopped
  stopped('stopped'),

  /// gameOver
  gameOver('gameOver');

  /// {@macro game_status}
  const GameStatus(this.value);

  /// Creates a new instance of [GameStatus] from a given string.
  static GameStatus fromValue(String? value, {GameStatus? fallback}) {
    switch (value) {
      case 'started':
        return started;
      case 'stopped':
        return stopped;
      case 'gameOver':
        return gameOver;
      default:
        return fallback ?? (throw ArgumentError.value(value));
    }
  }

  /// Value of the enum
  final String value;

  bool get isStarted => this == GameStatus.started;
  bool get isGameOver => this == GameStatus.gameOver;
  bool get isStopped => this == GameStatus.gameOver;

  /// Pattern matching
  T map<T>({
    required T Function() started,
    required T Function() stopped,
    required T Function() gameOver,
  }) {
    switch (this) {
      case GameStatus.started:
        return started();
      case GameStatus.stopped:
        return stopped();
      case GameStatus.gameOver:
        return gameOver();
    }
  }

  /// Pattern matching
  T maybeMap<T>({
    required T Function() orElse,
    T Function()? started,
    T Function()? stopped,
    T Function()? gameOver,
  }) =>
      map<T>(
        started: started ?? orElse,
        stopped: stopped ?? orElse,
        gameOver: gameOver ?? orElse,
      );

  /// Pattern matching
  T? maybeMapOrNull<T>({
    T Function()? started,
    T Function()? stopped,
    T Function()? gameOver,
  }) =>
      maybeMap<T?>(
        orElse: () => null,
        started: started,
        stopped: stopped,
        gameOver: gameOver,
      );

  @override
  int compareTo(GameStatus other) => index.compareTo(other.index);

  @override
  String toString() => value;
}
