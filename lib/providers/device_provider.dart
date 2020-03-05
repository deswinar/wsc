import 'package:flutter/material.dart';

class DeviceProvider extends ChangeNotifier {
  String _title = "";
  String _description = "";

  String get title => _title;
  String get description => _description;

  set title(String title) {
    _title = title;
    notifyListeners();
  }

  set description(String description) {
    _description = description;
    notifyListeners();
  }

  update(String title, String description) {
    _title = title;
    _description = description;
    notifyListeners();
  }
}