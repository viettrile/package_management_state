import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:manage_state_package/src/flutter_bloc.dart';

typedef BlocWidgetListener<T> = void Function(
    BuildContext context, BlocState<T> state);

class BlocConsumer<B extends Bloc<T>, T> extends StatefulWidget {
  final B? bloc;
  final BlocWidgetBuilder<T> builder;
  final BlocWidgetListener<T> listener;
  final bool Function(BlocState<T> previous, BlocState<T> current)? listenWhen;

  const BlocConsumer({
    Key? key,
    this.bloc,
    required this.builder,
    required this.listener,
    this.listenWhen,
  }) : super(key: key);

  @override
  State<BlocConsumer<B, T>> createState() => _BlocConsumerState<B, T>();
}

class _BlocConsumerState<B extends Bloc<T>, T>
    extends State<BlocConsumer<B, T>> {
  late B _bloc;
  StreamSubscription<BlocState<T>>? _subscription;

  @override
  void initState() {
    super.initState();
    _bloc = widget.bloc ?? BlocProvider.of<B>(context);
    _subscribe();
  }

  @override
  void didUpdateWidget(BlocConsumer<B, T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    final oldBloc = oldWidget.bloc ?? BlocProvider.of<B>(context);
    final currentBloc = widget.bloc ?? oldBloc;
    if (oldBloc != currentBloc) {
      _unsubscribe();
      _bloc = currentBloc;
      _subscribe();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<B, T>(
      bloc: _bloc,
      builder: widget.builder,
    );
  }

  void _subscribe() {
    _subscription = _bloc.stream.listen((state) {
      final shouldListen = widget.listenWhen?.call(_bloc.state, state) ?? true;
      if (shouldListen) {
        widget.listener(context, state);
      }
    });
  }

  void _unsubscribe() {
    _subscription?.cancel();
    _subscription = null;
  }

  @override
  void dispose() {
    _unsubscribe();
    super.dispose();
  }
}
