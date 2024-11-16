import 'package:flutter/widgets.dart';
import 'package:manage_state_package/src/flutter_bloc.dart';

typedef BlocWidgetBuilder<T> = Widget Function(
    BuildContext context, BlocState<T> state);

class BlocBuilder<B extends Bloc<T>, T> extends StatefulWidget {
  final B? bloc;
  final BlocWidgetBuilder<T> builder;
  final bool Function(BlocState<T> previous, BlocState<T> current)? buildWhen;

  const BlocBuilder({
    Key? key,
    this.bloc,
    required this.builder,
    this.buildWhen,
  }) : super(key: key);

  @override
  State<BlocBuilder<B, T>> createState() => _BlocBuilderState<B, T>();
}

class _BlocBuilderState<B extends Bloc<T>, T> extends State<BlocBuilder<B, T>> {
  late B _bloc;
  late BlocState<T> _state;

  @override
  void initState() {
    super.initState();
    _bloc = widget.bloc ?? BlocProvider.of<B>(context);
    _state = _bloc.state;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<BlocState<T>>(
      stream: _bloc.stream,
      initialData: _state,
      builder: (context, snapshot) {
        final state = snapshot.data!;

        if (widget.buildWhen != null) {
          if (!widget.buildWhen!(_state, state)) {
            return widget.builder(context, _state);
          }
        }

        _state = state;
        return widget.builder(context, state);
      },
    );
  }

  @override
  void dispose() {
    if (widget.bloc == null) {
      _bloc.dispose();
    }
    super.dispose();
  }
}
