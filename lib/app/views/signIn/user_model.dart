class UserModel {
  String token;
  UserData user;
  UserModel({final this.token, final this.user});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        token: json['token'], user: UserData.fromJson(json['user']));
  }
}

class UserData {
  String id;
  String firstName;
  String lastName;
  String nickName;
  String email;
  UserData(
      {final this.email,
      final this.firstName,
      final this.id,
      final this.lastName,
      final this.nickName});

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
        id: json['_id'],
        email: json['email'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        nickName: json['nickName']);
  }
}
