import 'package:flutter/material.dart';
import 'package:flutter_instagram_clone/base/screen_state.dart';

class ViewModel extends ChangeNotifier{
  ScreenState state = ScreenState.initial;
  String errorMessage = "";

  initialState(){
    state = ScreenState.initial;
    notifyListeners();
  }

  loadingState(){
    state = ScreenState.loading;
    notifyListeners();
  }

  successfulState(){
    state = ScreenState.success;
    notifyListeners();
  }

  errorState(){
    state = ScreenState.error;
    notifyListeners();
  }
}