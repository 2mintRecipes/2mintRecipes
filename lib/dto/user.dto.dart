import 'package:firebase_auth/firebase_auth.dart';

class UserDto {
  String? uid;
  String? fullName; // displayName
  String? username;
  String? email;
  String? avatar; // photoURL
  String? phone; // phoneNumber
  String? address;
  String? gender;

  UserDto({
    this.uid,
    this.fullName,
    this.username,
    this.email,
    this.avatar,
    this.phone,
    this.address,
    this.gender,
  });

  factory UserDto.fromJson(Map<String, dynamic> json) => UserDto(
        uid: json["uid"],
        fullName: json["fullName"],
        username: json["username"],
        email: json["email"],
        avatar: json["avatar"],
        phone: json["phone"],
        address: json["address"],
        gender: json["gender"],
      );

  factory UserDto.fromRawUser(User user) => UserDto(
        uid: user.uid,
        fullName: user.displayName,
        username: null,
        email: user.email,
        avatar: user.photoURL,
        phone: user.phoneNumber,
        address: null,
        gender: null,
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "fullName": fullName,
        "username": username,
        "email": email,
        "avatar": avatar,
        "phone": phone,
        "gender": gender,
        "address": address,
      };
}
