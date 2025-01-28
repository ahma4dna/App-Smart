import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TheamProvider with ChangeNotifier {
  static TheamProvider get(context) => Provider.of(context);
  static const theaneStatus = 'TTEAM_STATU';
  bool darkTheam = false;
  bool get getIsDarkTheam => darkTheam;
  Future<void> setTheam({required bool theamValue}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool(theaneStatus, theamValue);
    darkTheam = theamValue;
    notifyListeners();
  }

  Future<void> getTheam() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    darkTheam = preferences.getBool(theaneStatus) ?? false;
    notifyListeners();
  }


}
