import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:x2mint_recipes/dto/user.dto.dart';
import 'package:x2mint_recipes/services/recipes.service.dart';
import 'package:x2mint_recipes/services/seccure_storage.dart';
import 'package:x2mint_recipes/services/user.service.dart';
import 'package:x2mint_recipes/utils/app_ui.dart';

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
  late UserDto _user;
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
          _user = UserDto.fromJson(snapshot.data);

          return Row(
            children: [
              ClipOval(
                child: ((_user.avatar != '')
                    ? Image.network(
                        _user.avatar!,
                        width: 35,
                        height: 35,
                        fit: BoxFit.cover,
                      )
                    : CircleAvatar(
                        backgroundColor: Color(
                                (math.Random().nextDouble() * 0xFFFFFF).toInt())
                            .withOpacity(1.0),
                        child: Text(
                          _user.username!.substring(0, 2),
                          style: const TextStyle(color: Colors.white),
                        ),
                      )),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _user.fullName ?? " ",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white.withOpacity(.7),
                      ),
                    ),
                    Text(
                      _user.username ?? ' ',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white.withOpacity(.7),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              )
            ],
          );
        }
        return Container();
      },
    );
  }
}
