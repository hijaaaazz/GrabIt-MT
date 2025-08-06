// viewmodels/main_view_model.dart
import 'dart:developer';

import 'package:flutter/material.dart';

class MainViewModel extends ChangeNotifier {
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  void setTab(int index) {
    log('MainViewModel.setTab called with index: $index');
    log('Current index before change: $_currentIndex');
    
    if (_currentIndex != index) {
      _currentIndex = index;
      log('Index changed to: $_currentIndex');
      notifyListeners();
      log('notifyListeners() called');
    } else {
      log('Same index, no change needed');
    }
  }
}