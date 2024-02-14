import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartNotifier extends ChangeNotifier {
  int _cartItemCount = 0;

  int get cartItemCount => _cartItemCount;

  Future<void> setprefernece() async {
    SharedPreferences pref =await SharedPreferences.getInstance();
    pref.setInt("cart_item", _cartItemCount);
    notifyListeners();
  }

  Future<void> getprefernece() async {
    SharedPreferences pref =await SharedPreferences.getInstance();
    _cartItemCount = pref.getInt("cart_item") ?? 0;

    notifyListeners();
  }

  void increment() {
    _cartItemCount++;
    setprefernece();
    notifyListeners();
  }

  void decrement() {
    if (_cartItemCount > 0) {
      _cartItemCount--;
      setprefernece();
      notifyListeners();
    }
  }

  int getcounter(){
    getprefernece();
    return _cartItemCount;
  }

}
