import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:x2mint_recipes/services/recipes.service.dart';
import 'package:x2mint_recipes/services/seccure_storage.dart';
import 'package:x2mint_recipes/services/user.service.dart';

import '../../utils/app_ui.dart';

class Creator extends StatefulWidget {
  final String id;
  const Creator(this.id, {Key? key}) : super(key: key);
  @override
  State<Creator> createState() => _CreatorState();
}

class _CreatorState extends State<Creator> {
  SecureStorage secureStorage = SecureStorage();
  UserService userService = UserService();
  late Future _userFuture;
  late Map<String, dynamic> _user;
  late String id = widget.id;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future init() async {
    _userFuture = userService.getOne(id);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _userFuture,
        builder: (
          BuildContext context,
          AsyncSnapshot snapshot,
        ) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          if (snapshot.hasData) {
            _user = snapshot.data;
            //print(_user);
            return Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white.withOpacity(.5),
                  child: const Text(
                    'MT',
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                ),
                Text(
                  '  By ' + _user['fullname'],
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white.withOpacity(.7),
                  ),
                )
              ],
            );
          }
          return Container();
        });
  }
}
