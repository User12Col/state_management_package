import 'dart:async';

class StateNotifier<T> {
  /// State
  T _state;
  final _controller = StreamController<T>.broadcast();

  StateNotifier(this._state);

  /// Getter
  T get state => _state;

  /// Setter
  set state(T value) {
    if (_state != value) {
      _state = value;
      _notifyListeners();
    }
  }

  Stream<T> get stream => _controller.stream;

  void _notifyListeners() {
    _controller.add(_state);
  }

  void dispose() {
    _controller.close();
  }
}
