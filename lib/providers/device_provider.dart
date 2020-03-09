import 'package:flutter/material.dart';

class DeviceProvider extends ChangeNotifier {
  String _title = "";
  String _description = "";
  String _date = "";
  String _time = "";

  String get title => _title;
  String get description => _description;
  String get date => _date;
  String get time => _time;

  set title(String title) {
    _title = title;
    notifyListeners();
  }

  set description(String description) {
    _description = description;
    notifyListeners();
  }

  void setDate(String date) {
    _date = date;
    notifyListeners();
  }

  void setTime(String time) {
    _time = time;
    notifyListeners();
  }

  update(String title, String description) {
    _title = title;
    _description = description;
    notifyListeners();
  }
}