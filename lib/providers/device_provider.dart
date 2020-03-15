import 'package:flutter/material.dart';

class DeviceProvider extends ChangeNotifier {
  String id;
  String title;
  String description;
  String date;
  String time;
  String triggerTime;
  bool triggerTo;
  bool status;


  DeviceProvider({
    this.id,
    this.title,
    this.description,
    this.triggerTime,
    this.triggerTo,
    this.status
  });

  void setTitle(String title) {
    this.title = title;
    notifyListeners();
  }

  void setDescription(String description) {
    this.description = description;
    notifyListeners();
  }

  void setTriggerTime(String triggerTime) {
    this.triggerTime = triggerTime;
    notifyListeners();
  }

  void setTriggerTo(bool triggerTo) {
    this.triggerTo = triggerTo;
    notifyListeners();
  }

  void setDate(String date) {
    this.date = date;
    notifyListeners();
  }

  void setTime(String time) {
    this.time = time;
    notifyListeners();
  }

  void setStatus(bool status) {
    this.status = status;
    notifyListeners();
  }

  update(String title, String description) {
    this.title = title;
    this.description = description;
    notifyListeners();
  }

  factory DeviceProvider.fromMap(Map<String, dynamic> data) {
    return DeviceProvider(
      id: data['id'] ?? '',
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      triggerTime: data['trigger_time'] ?? '',
      triggerTo: data['trigger_to'] ?? false,
      status: data['status'] ?? false,
    );
  }

  factory DeviceProvider.initialData() {
    return DeviceProvider(
      id: '',
      title: '',
      description: '',
      triggerTime: '',
      triggerTo: false,
      status: false,
    );
  }
}