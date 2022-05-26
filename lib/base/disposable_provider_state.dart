import 'package:flutter/material.dart';
import 'package:flutter_instagram_clone/base/disposable_provider.dart';

abstract class DisposableProviderState<T extends StatefulWidget> extends State<T> implements DisposableProvider{
  @override
  void deactivate() {
    disposeProviderValue();
    super.deactivate();
  }
}