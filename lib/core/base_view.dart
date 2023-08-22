import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

class BaseView<T extends Store> extends StatefulWidget {
  final Widget Function(BuildContext context, T value, ThemeData theme)
      onPageBuilder;
  final T viewModel;
  final Function(T model) onModelReady;
  final Function(T model)? onDispose;
  final Function(T model)? reassemble;

  const BaseView({
    Key? key,
    required this.onPageBuilder,
    required this.viewModel,
    required this.onModelReady,
    this.onDispose,
    this.reassemble,
  }) : super(key: key);

  @override
  BaseViewState<T> createState() => BaseViewState<T>();
}

class BaseViewState<T extends Store> extends State<BaseView<T>> {
  late T model;

  @override
  initState() {
    model = widget.viewModel;
    widget.onModelReady(model);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);

    return widget.onPageBuilder(context, model, themeData);
  }

  @override
  dispose() {
    if (widget.onDispose != null) widget.onDispose!(model);
    super.dispose();
  }

  @override
  reassemble() {
    if (widget.reassemble != null) widget.reassemble!(model);

    super.reassemble();
  }
}
