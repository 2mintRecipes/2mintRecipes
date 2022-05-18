class UserDto {
  String fullname;
  String? username;
  String? avatar;
  String? phone;
  String? address;
  String? gender;

  UserDto(
      {required this.fullname,
      this.username,
      this.avatar,
      this.phone,
      this.address,
      this.gender});

  factory UserDto.fromJson(Map<String, dynamic> json) => UserDto(
        fullname: json["fullname"],
        username: json["username"],
        avatar: json["avatar"],
        phone: json["phone"],
        address: json["address"],
        gender: json["gender"],
      );

  Map<String, dynamic> toJson() => {
        "fullname": fullname,
        "username": username,
        "avatar": avatar,
        "phone": phone,
        "gender": gender,
        "address": address,
      };
}
