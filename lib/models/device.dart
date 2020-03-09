import 'package:flutter/material.dart';

class Device {
  final String title;
  final String description;

  Device({this.title, this.description});

  factory Device.fromMap(Map data) {
    return Device(
      title: data['title'] ?? '',
      description: data['description'] ?? '',
    );
  }
}