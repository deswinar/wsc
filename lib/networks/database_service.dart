import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wsc/models/device.dart';
import 'package:wsc/providers/device_provider.dart';

class DatabaseService {
  final Firestore _db = Firestore.instance;

  Future<Device> streamDevice(String id) async {
    var snap = await _db.collection('devices').document(id).get();

    return Device.fromMap(snap.data);
  }

  getDevices() {
    return _db.collection('devices').snapshots();
  }

  Stream<DeviceProvider> getDevice(String id) {
    return _db
        .collection('devices')
        .document(id)
        .snapshots()
        .map((list) => DeviceProvider.fromMap(list.data));
  }

  Future<void> updateDevice(String id, data) {
    return _db.collection('devices').document(id).updateData(data);
  }
}