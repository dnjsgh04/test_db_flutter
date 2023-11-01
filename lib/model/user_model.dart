import 'dart:convert';

List<UserModel> userModelFromJson(String str) => List<UserModel>.from(json.decode(str).map((x) => UserModel.fromJson(x)));

String userModelToJson(List<UserModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserModel {
  String memberId;
  String memberPw;
  int memberAge;
  String memberName;

  UserModel({
    required this.memberId,
    required this.memberPw,
    required this.memberAge,
    required this.memberName,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    memberId: json["member_id"],
    memberPw: json["member_pw"],
    memberAge: json["member_age"],
    memberName: json["member_name"],
  );

  Map<String, dynamic> toJson() => {
    "member_id": memberId,
    "member_pw": memberPw,
    "member_age": memberAge,
    "member_name": memberName,
  };
}