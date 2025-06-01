import 'package:flutter/material.dart';

class BottomnavbarController extends ChangeNotifier{
  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;

  void setSelectedIndex(int index){
    _selectedIndex = index;
    notifyListeners();
  }


}