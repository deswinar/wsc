import 'package:flutter/material.dart';

class DeviceProvider {
  String _title = "";
  String _description = "";

  String get title => _title;
  String get description => _description;

  DeviceProvider.fromMap(Map snapshot, String id) {
    id = id ?? '';
    title = snapshot['title'] ?? '';
    description = snapshot['description'] ?? '';
  }

  toJson() {
    return {
      "title": title,
      "description": description,
    };
  }

  set title(String title) {
    _title = title;
  }

  set description(String description) {
    _description = description;
  }
}