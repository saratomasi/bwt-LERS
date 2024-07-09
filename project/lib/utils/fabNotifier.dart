import 'package:flutter/material.dart';

class FabStateNotifier extends ValueNotifier<bool> {
  FabStateNotifier() : super(false);

  void toggle() {
    value = !value;
  }

  void close() {
    value = false;
  }
}

final fabStateNotifier = FabStateNotifier();
