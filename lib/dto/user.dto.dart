class UserDto {
  String fullName;
  String? username;
  String? avatar;
  String? phone;
  String? address;
  String? gender;

  UserDto(
      {required this.fullName,
      this.username,
      this.avatar,
      this.phone,
      this.address,
      this.gender});

  factory UserDto.fromJson(Map<String, dynamic> json) => UserDto(
        fullName: json["fullName"],
        username: json["username"],
        avatar: json["avatar"],
        phone: json["phone"],
        address: json["address"],
        gender: json["gender"],
      );

  Map<String, dynamic> toJson() => {
        "fullName": fullName,
        "username": username,
        "avatar": avatar,
        "phone": phone,
        "gender": gender,
        "address": address,
      };
}
