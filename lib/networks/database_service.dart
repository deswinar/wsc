import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wsc/models/device.dart';

class DatabaseService {
  final Firestore _db = Firestore.instance;

  Future<Device> streamDevice(String id) async {
    var snap = await _db.collection('devices').document(id).get();

    return Device.fromMap(snap.data);
  }

  getDevices() {
    return _db.collection('devices').snapshots();
  }

  getDevice(String id) {
    return _db
        .collection('devices')
        .document(id)
        .snapshots();
  }

  updateDevice(String id, data) {
    return _db.collection('devices').document(id).updateData(data);
  }
}