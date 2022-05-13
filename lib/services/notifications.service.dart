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
}
