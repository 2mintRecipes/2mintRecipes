import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageService {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;
  static getInstance() {
    if (_db == null) {
      return FirebaseFirestore.instance;
    } else {
      return _db;
    }
  }

  static Future add(String collection, dynamic data) async {
    return _db
        .collection(collection)
        .add(data)
        .then((DocumentReference doc) => doc);
  }

  static Future getAll(String collection) async {
    List<Map<String, dynamic>> result = [];

    await _db.collection(collection).get().then((event) {
      event.docs.forEach((doc) {
        result.add(doc.data());
      });
    });

    return result;
  }

  static Future get(String collection) async {
    await _db.collection(collection).get().then((event) {
      for (var doc in event.docs) {
        print("${doc.id} => ${doc.data()}");
      }
    });
  }
}
