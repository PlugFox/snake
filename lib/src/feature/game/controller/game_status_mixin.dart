part of 'game_controller.dart';

mixin _GameStatusMixin on ChangeNotifier {
  void _setStatus(GameStatus newStatus) {
    if (newStatus == _$status) return;
    _$status = newStatus;
    notifyListeners();
  }

  GameStatus _$status = GameStatus.stopped;
}
