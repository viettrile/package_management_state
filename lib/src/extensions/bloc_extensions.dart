import 'package:manage_state_package/src/flutter_bloc.dart';

extension BlocExtensions<T> on Bloc<T> {
  // Tiện ích kiểm tra trạng thái
  bool get isLoading => state.isLoading;
  bool get hasError => state.error != null;
  String? get errorMessage => state.error;
  T get currentData => state.data;
  
  // Tiện ích xử lý error
  void clearError() {
    emit(state.data);
  }

  // Tiện ích reset state
  void resetToInitial(T initialData) {
    emit(initialData);
  } 
} 