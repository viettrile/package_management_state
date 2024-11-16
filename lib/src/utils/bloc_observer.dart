import 'package:manage_state_package/src/flutter_bloc.dart';  

abstract class BlocObserver {
  void onCreate(Bloc bloc) {}

  void onEvent(Bloc bloc, Object? event) {}

  void onChange(Bloc bloc, BlocState state) {}

  void onError(Bloc bloc, Object error, StackTrace stackTrace) {}

  void onClose(Bloc bloc) {}

  void onStateChanged(Bloc bloc, BlocState oldState, BlocState newState) {}
}

class SimpleBlocObserver extends BlocObserver {
  final bool enableDebugPrint;

  SimpleBlocObserver({this.enableDebugPrint = true});

  @override
  void onCreate(Bloc bloc) {
    if (enableDebugPrint) {
      print('🟢 onCreate -- ${bloc.runtimeType}');
    }
    super.onCreate(bloc);
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    if (enableDebugPrint) {
      print('🔄 onEvent -- ${bloc.runtimeType}');
      print('  ├─ Event: $event');
    }
    super.onEvent(bloc, event);
  }

  @override
  void onChange(Bloc bloc, BlocState state) {
    if (enableDebugPrint) {
      print('🔄 onChange -- ${bloc.runtimeType}');
      print('  ├─ Data: ${state.data}');
      print('  ├─ Loading: ${state.isLoading}');
      print('  ├─ Error: ${state.error}');
      print('  └─ LastUpdated: ${state.lastUpdated}');
    }
    super.onChange(bloc, state);
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stackTrace) {
    if (enableDebugPrint) {
      print('❌ onError -- ${bloc.runtimeType}');
      print('  ├─ Error: $error');
      print('  └─ StackTrace: $stackTrace');
    }
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(Bloc bloc) {
    if (enableDebugPrint) {
      print('🔴 onClose -- ${bloc.runtimeType}');
    }
    super.onClose(bloc);
  }
}
