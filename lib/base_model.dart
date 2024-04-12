import 'package:flutter/material.dart';

class BaseModel extends ChangeNotifier{
  bool isLoading = false;

  setState(bool state){
    isLoading = state;
    notifyListeners();
  }
}