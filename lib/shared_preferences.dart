import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wireguard_flutter/constants/constants.dart';

class MySharedPreferences {
  Future clearSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    return;
  }

  Future<String?> removeConfigString() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(Constants.ConfigData);
  }

  Future<String?> getConfigString() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var configDataString = prefs.getString(Constants.ConfigData);
    return configDataString;
  }

  Future setConfigString(String configDataString) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(Constants.ConfigData, configDataString);
  }
}
