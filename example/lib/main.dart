import 'package:flutter/material.dart';
import 'package:manage_state_package/src/flutter_bloc.dart';
import 'counter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        bloc: CounterBloc(),
        child: const CounterPage(),
      ),
    );
  }
}

class CounterPage extends StatelessWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter Demo'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              BlocProvider.of<CounterBloc>(context).reset(0);
            },
          ),
        ],
      ),
      body: Center(
        child: BlocConsumer<CounterBloc, int>(
          listener: (context, state) {
            if (state.error != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Error: ${state.error}')),
              );
            }
            if (state.data == 10) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Maximum value reached!')),
              );
            }
          },
          builder: (context, state) {
            if (state.isLoading) {
              return const CircularProgressIndicator();
            }

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Count: ${state.data}',
                  key: ValueKey(state.data),
                  style: const TextStyle(fontSize: 24),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if (!state.isLoading) {
                          BlocProvider.of<CounterBloc>(context).decrement();
                        }
                      },
                      child: const Text('-'),
                    ),
                    const SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: () {
                        if (!state.isLoading) {
                          BlocProvider.of<CounterBloc>(context).increment();
                        }
                      },
                      child: const Text('+'),
                    ),
                    const SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: () {
                        if (!state.isLoading) {
                          BlocProvider.of<CounterBloc>(context).incrementAsync();
                        }
                      },
                      child: const Text('+ Async'),
                    ),
                  ],
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
