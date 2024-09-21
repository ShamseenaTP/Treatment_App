// ignore_for_file: public_member_api_docs, sort_constructors_first
class LoginResponseModel {
  final String? token;
  final String? message;

  LoginResponseModel({
    this.token,
    this.message,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
        token: json["token"] ?? "",
        message: json["message"] ?? "");
  }
  Map<String, dynamic> toJson(){
    Map<String, dynamic> map = {
      "token":token!.trim(),
      "message":message!.trim()
    };
    return map;
  }
}

class UserDetails {
  String? username;
  String? password;

  UserDetails({this.username, this.password});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      "username": username!.trim(),
      "password": password!.trim()
    };
    return map;
  }
}
