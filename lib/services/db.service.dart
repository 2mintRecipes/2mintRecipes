import 'package:cloud_firestore/cloud_firestore.dart';

class StorageService {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;
  static FirebaseFirestore getInstance() {
    if (_db == null) {
      return FirebaseFirestore.instance;
    } else {
      //print(_db);
      return _db;
    }
  }

  static CollectionReference<Map<String, dynamic>> getCollection(
      String collectionName) {
    return getInstance().collection(collectionName);
  }

  static Future update(
    String collectionName,
    String path,
    dynamic data,
  ) async {
    return await getCollection(collectionName).doc(path).update(data);
  }

  static Future add(String collectionName, dynamic data) async {
    return await getCollection(collectionName).add(data);
  }

  static Future delete(String collectionName, String path) async {
    return await getCollection(collectionName).doc(path).delete();
  }

  static Future getAll(String collectionName) async {
    List<Map<String, dynamic>> result = [];
    await getCollection(collectionName).get().then((event) {
      event.docs.forEach((doc) {
        var value = doc.data();
        value['id'] = doc.id;
        result.add(value);
      });
    });

    return result;
  }

  static Future getOne(String collectionName, String path) async {
    Map<String, dynamic>? result;

    await getCollection(collectionName).doc(path).get().then((doc) {
      result = doc.data();
      result?['id'] = doc.id;
    });

    return result;
  }

  static Future getDocRef(String collectionName, String path) async {
    return getCollection(collectionName).doc(path);
  }

  static Future search({
    required String collectionName,
    required String fieldName,
    required dynamic value,
    int limit = 10,
    // int offset = 0,
    bool descending = false,
  }) async {
    List<Map<String, dynamic>>? result = [];

    var snapshot = await getCollection(collectionName)
        .where(fieldName, isEqualTo: value)
        // .orderBy(fieldName, descending: descending)
        .limit(limit)
        // .startAt([offset])
        .get();

    snapshot.docs.forEach((doc) {
      var value = doc.data();
      value['id'] = doc.id;
      result.add(value);
    });

    return result;
  }

  static Future searchGreather({
    required String collectionName,
    required String fieldName,
    required dynamic value,
    int limit = 10,
    // int offset = 0,
    bool descending = false,
  }) async {
    List<Map<String, dynamic>>? result = [];

    var snapshot = await getCollection(collectionName)
        .where(fieldName, isGreaterThan: value)
        // .orderBy(fieldName, descending: descending)
        .limit(limit)
        // .startAt([offset])
        .get();

    snapshot.docs.forEach((doc) {
      var value = doc.data();
      value['id'] = doc.id;
      result.add(value);
    });

    return result;
  }

  static Future searchLike({
    required String collectionName,
    required String fieldName,
    required dynamic value,
  }) async {
    List<Map<String, dynamic>>? result = [];

    await getCollection(collectionName).get().then((event) {
      event.docs.forEach((doc) {
        var data = doc.data();
        if (data[fieldName]?.toString().contains(value) ?? false) {
          result.add(data);
        }
      });
    });

    return result;
  }
}
