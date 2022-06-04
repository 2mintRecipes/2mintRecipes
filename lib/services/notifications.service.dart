import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:x2mint_recipes/services/db.service.dart';

class NotificationsService {
  Future getAll() async {
    try {
      List<Map<String, dynamic>> result =
          await StorageService.getAll('notifications');

      return result;
    } catch (e) {
      print(e);
    }
  }

  Future get(String path) async {
    try {
      return await StorageService.getOne('notifications', path);
    } catch (e) {
      print(e);
    }
  }

  Future getByType(String typeValue) async {
    try {
      return await StorageService.search(
        collectionName: 'notifications',
        fieldName: 'type',
        value: typeValue,
      );
    } catch (e) {
      print(e);
    }
  }

  Future makeNotificationRead(String path) async {
    try {
      return await StorageService.update('notifications', path, {
        'status': 'READ',
      });
    } catch (e) {
      print(e);
    }
  }

  Future removeNotification(String path) async {
    try {
      return await StorageService.delete('notifications', path);
    } catch (e) {
      print(e);
    }
  }

  Future getNotificationsByStatus(String status) async {
    try {
      // List<Map<String, dynamic>> result = [];

      if (status == 'ALL') {
        return await StorageService.getAll('notifications');
      } else {
        return await StorageService.search(
          collectionName: "notifications",
          fieldName: "status",
          value: status,
        );
      }
    } catch (e) {
      print(e);
    }
  }
}
