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

  Future getNotificationsByStatus(String status) async {
    try {
      List<Map<String, dynamic>> result = [];

      if (status == 'ALL') {
        result = await StorageService.getAll('notifications');
      } else {
        StorageService.getCollection("notifications")
            .where("status", isEqualTo: status)
            .get()
            .then((event) {
          event.docs.forEach((doc) {
            result.add(doc.data());
          });
        });
      }

      print(result);

      return result;
    } catch (e) {
      print(e);
    }
  }
}
