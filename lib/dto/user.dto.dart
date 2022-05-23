class UserDto {
  String? id;
  String? fullName;
  String? username;
  String? avatar;
  String? phone;
  String? address;
  String? gender;

  UserDto({
    this.id,
    this.fullName,
    this.username,
    this.avatar,
    this.phone,
    this.address,
    this.gender,
  });

  factory UserDto.fromJson(Map<String, dynamic> json) => UserDto(
        id: json["id"],
        fullName: json["fullName"],
        username: json["username"],
        avatar: json["avatar"],
        phone: json["phone"],
        address: json["address"],
        gender: json["gender"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fullName": fullName,
        "username": username,
        "avatar": avatar,
        "phone": phone,
        "gender": gender,
        "address": address,
      };
}
