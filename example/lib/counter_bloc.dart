import 'package:manage_state_package/src/flutter_bloc.dart';

class CounterBloc extends Bloc<int> {
  CounterBloc() : super(0);

  void increment() {
    if (state.data < 10) {
      emit(state.data + 1);
    }
  }

  void decrement() {
    emit(state.data - 1);
  }

  Future<void> incrementAsync() async {
    try {
      emit(state.data);
      await Future.delayed(const Duration(seconds: 1));
      if (state.data < 10) {
        emit(state.data + 1);
      }
    } catch (e) {
      emit(state.data);
    }
  }
  void reset(int initialState) {
    emit(initialState);
  }
} 