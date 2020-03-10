import 'package:flutter/material.dart';

class DeviceProvider extends ChangeNotifier {
  String _title = "";
  String _description = "";
  String _date = "";
  String _time = "";
  bool _triggerTo = true;
  bool _status = true;

  String get title => _title;
  String get description => _description;
  String get date => _date;
  String get time => _time;
  bool get triggerTo => _triggerTo;
  bool get status => _status;

  set title(String title) {
    _title = title;
    notifyListeners();
  }

  set description(String description) {
    _description = description;
    notifyListeners();
  }

  set triggerTo(bool triggerTo) {
    _triggerTo = triggerTo;
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

  void setTriggerTo(bool triggerTo) {
    _triggerTo = triggerTo;
    notifyListeners();
  }

  void setStatus(bool status) {
    _status = status;
    notifyListeners();
  }

  update(String title, String description) {
    _title = title;
    _description = description;
    notifyListeners();
  }
}