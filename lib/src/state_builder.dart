import 'package:flutter/material.dart';
import 'package:state_management_package/src/state_provider.dart';

class StateBuilder<T> extends StatelessWidget {
  final StateProvider<T> provider;
  final Widget Function(BuildContext, T) builder;

  const StateBuilder(
      {super.key, required this.provider, required this.builder});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<T>(
      /// Listen to state change via stream of StateNotifier
      stream: provider.notifier.stream,
      initialData: provider.state,
      builder: (context, snapshot) {
        return builder(context, snapshot.data ?? provider.state);
      },
    );
  }
}
