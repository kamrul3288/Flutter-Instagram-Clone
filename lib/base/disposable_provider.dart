import 'package:flutter/material.dart';

abstract class DisposableProvider extends ChangeNotifier{
  void disposeProviderValue();
}