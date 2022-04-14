import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web3_flutter/base/view_model.dart';
import 'package:web3_flutter/locator.dart';

class ViewModelProviderWidget<T extends ViewModel> extends StatefulWidget {
  const ViewModelProviderWidget({
    Key? key,
    required this.builder,
    this.onModelProvided,
    this.child,
  }) : super(key: key);

  final Widget Function(BuildContext context, T model, Widget? child) builder;
  final Function(T)? onModelProvided;
  final Widget? child;

  @override
  _ViewModelProviderWidgetState<T> createState() =>
      _ViewModelProviderWidgetState<T>();
}

class _ViewModelProviderWidgetState<T extends ViewModel>
    extends State<ViewModelProviderWidget<T>> {
  late T model;

  @override
  void initState() {
    super.initState();
    model = locator<T>();
    widget.onModelProvided?.call(model);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>(
      create: (context) => model,
      child: Consumer<T>(
        builder: widget.builder,
        child: widget.child,
      ),
    );
  }
}
