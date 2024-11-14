import 'package:flutter/material.dart';
import 'package:state_management_package/state_management_package.dart';

class CounterScreen extends StatefulWidget {
  const CounterScreen({super.key});

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  final StateProvider<int> counterProvider =
      StateProvider<int>(StateNotifier<int>(0));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Package State Management")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomLeft,
              child: FloatingActionButton(
                onPressed: () =>
                    counterProvider.update(counterProvider.state - 1),
                child: const Icon(Icons.remove),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                onPressed: () =>
                    counterProvider.update(counterProvider.state + 1),
                child: const Icon(Icons.add),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: FloatingActionButton(
                onPressed: () => counterProvider.reset(0),
                child: const Icon(Icons.restore),
              ),
            ),
            Center(
              child: StateBuilder<int>(
                provider: counterProvider,
                builder: (context, count) => Text('Count: $count'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
