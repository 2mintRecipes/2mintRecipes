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

  static getCollection(String collectionName) {
    return getInstance().getCollection(collectionName);
  }

  static Future add(String collectionName, dynamic data) async {
    return getCollection(collectionName)
        .add(data)
        .then((DocumentReference doc) => doc);
  }

  static Future getAll(String collectionName) async {
    List<Map<String, dynamic>> result = [];

    await getCollection(collectionName).get().then((event) {
      event.docs.forEach((doc) {
        result.add(doc.data());
      });
    });

    return result;
  }

  static Future get(String collectionName) async {
    await getCollection(collectionName).get().then((event) {
      for (var doc in event.docs) {
        print("${doc.id} => ${doc.data()}");
      }
    });
  }
}
