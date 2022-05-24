import '../utils/app_ui.dart';

class Model {
  final int id;
  final String imagePath;
  final String name;

  Model({
    required this.id,
    required this.imagePath,
    required this.name,
  });
}

List<Model> navBtn = [
  Model(id: 0, imagePath: UI.home, name: 'Home'),
  Model(id: 1, imagePath: UI.bookmark, name: 'Bookmark'),
  Model(id: 2, imagePath: UI.create, name: 'Create'),
  Model(id: 3, imagePath: UI.notify, name: 'Notify'),
  Model(id: 4, imagePath: UI.account, name: 'Profile'),
  Model(id: 5, imagePath: UI.homeActive, name: 'Home'),
  Model(id: 6, imagePath: UI.bookmarkActive, name: 'Bookmark'),
  Model(id: 7, imagePath: UI.createActive, name: 'Create'),
  Model(id: 8, imagePath: UI.notifyActive, name: 'Notify'),
  Model(id: 9, imagePath: UI.accountActive, name: 'Profile'),
];
