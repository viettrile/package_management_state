import 'package:flutter_test/flutter_test.dart';
import '../lib/counter_bloc.dart';

void main() {
  group('CounterBloc', () {
    late CounterBloc bloc;

    setUp(() {
      bloc = CounterBloc();
    });

    tearDown(() {
      bloc.dispose();
    });

    test('initial state is 0', () {
      expect(bloc.state.data, equals(0));
    });

    test('increment adds 1 to state', () {
      bloc.increment();
      expect(bloc.state.data, equals(1));
    });

    test('decrement subtracts 1 from state', () {
      bloc.increment();
      bloc.decrement();
      expect(bloc.state.data, equals(0));
    });

    test('cannot increment above 10', () {
      for (var i = 0; i < 15; i++) {
        bloc.increment();
      }
      expect(bloc.state.data, equals(10));
    });

    test('reset returns state to 0', () {
      bloc.increment();
      bloc.reset(0);
      expect(bloc.state.data, equals(0));
    });
  });
} 