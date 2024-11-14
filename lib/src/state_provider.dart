import 'package:state_management_package/src/state_notifier.dart';

class StateProvider<T> {
  StateNotifier<T> notifier;
  StateProvider(this.notifier);

  T get state => notifier.state;

  /// Update state
  void update(T value) {
    notifier.state = value;
  }

  /// Reset state
  void reset(T initialState) {
    notifier.state = initialState;
  }

  Future<void> updateAsync(Future<T> futureValue) async {
    notifier.state = await futureValue;
  }
}
