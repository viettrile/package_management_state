import 'package:flutter/widgets.dart';
import 'package:manage_state_package/src/flutter_bloc.dart';

class BlocProvider<T extends Bloc> extends InheritedWidget {
  final T bloc;

  const BlocProvider({
    Key? key,
    required this.bloc,
    required Widget child,
  }) : super(key: key, child: child);

  static T of<T extends Bloc>(BuildContext context) {
    final provider = context.dependOnInheritedWidgetOfExactType<BlocProvider<T>>();
    assert(provider != null, 'No BlocProvider<$T> found in context');
    return provider!.bloc;
  }

  @override
  bool updateShouldNotify(BlocProvider<T> oldWidget) {
    return bloc != oldWidget.bloc;
  }
}
