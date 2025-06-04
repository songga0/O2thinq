import 'package:flutter/material.dart';

class AnimationStateProvider extends ChangeNotifier {
  bool _isRunning = true;

  bool get isRunning => _isRunning;

  void toggleAnimation() {
    _isRunning = !_isRunning;
    notifyListeners();
  }
}