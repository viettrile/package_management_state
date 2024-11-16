import 'dart:async';

import 'package:manage_state_package/src/flutter_bloc.dart';

abstract class Bloc<T> {
  late final StreamController<BlocState<T>> _controller;
  BlocState<T> _currentState;
  final List<Function> _listeners = [];

  Bloc(T initialData) : _currentState = BlocState<T>(data: initialData) {
    _controller = StreamController<BlocState<T>>.broadcast();
    _init();
  }

  // Hook để override cho initialization logic
  void _init() {}

  // Getter cho state hiện tại
  BlocState<T> get state => _currentState;

  // Stream để lắng nghe thay đổi
  Stream<BlocState<T>> get stream => _controller.stream;

  // Cập nhật state đồng bộ
  void emit(T newData) {
    _updateState(_currentState.copyWith(
      data: newData,
      isLoading: false,
      error: null,
    ));
  }

  // Cập nhật state bất đồng bộ
  Future<void> emitAsync(Future<T> Function() action) async {
    try {
      _updateState(_currentState.copyWith(isLoading: true));
      final result = await action();
      _updateState(_currentState.copyWith(
        data: result,
        isLoading: false,
        error: null,
      ));
    } catch (e) {
      _updateState(_currentState.copyWith(
        isLoading: false,
        error: e.toString(),
      ));
    }
  }

  // Reset state về giá trị ban đầu
  void reset(T initialData) {
    _updateState(BlocState<T>(data: initialData));
  }

  // Thêm listener để lắng nghe thay đổi
  void addListener(Function(BlocState<T>) listener) {
    _listeners.add(listener);
  }

  // Xóa listener
  void removeListener(Function(BlocState<T>) listener) {
    _listeners.remove(listener);
  }

  void _updateState(BlocState<T> newState) {
    if (_currentState != newState) {
      _currentState = newState;
      if (!_controller.isClosed) {
        _controller.add(newState);
      }
      for (var listener in _listeners) {
        listener(newState);
      }
    }
  }

  // Dispose resources
  void dispose() {
    if (!_controller.isClosed) {
      _controller.close();
    }
    _listeners.clear();
    _currentState =
        BlocState<T>(data: _currentState.data); // Giữ nguyên data hiện tại
  }

  // Thêm phương thức
  void emitMultiple(List<T> states) {
    for (var state in states) {
      emit(state);
    }
  }

  // Thêm phương thức batch update
  void batchEmit(T Function(T currentData) updates) {
    final updatedData = updates(state.data);
    emit(updatedData);
  }

  // Thêm error handling helper
  Future<void> tryEmit(Future<T> Function() action) async {
    try {
      _updateState(_currentState.copyWith(isLoading: true));
      final result = await action();
      emit(result);
    } catch (e) {
      _updateState(_currentState.copyWith(
        error: e.toString(),
        isLoading: false,
      ));
    }
  }

  // Thêm phương thức validate trước khi emit
  void emitIf(T newData, bool Function(T currentData, T newData) condition) {
    if (condition(state.data, newData)) {
      emit(newData);
    }
  }
}
