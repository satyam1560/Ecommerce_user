// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class UserModel extends Equatable {
  String? email;
  String? fullName;
  String? uid;
  int? phoneNo;
  UserModel({
    this.email,
    this.fullName,
    this.uid,
    this.phoneNo,
  });

  @override
  List<Object?> get props => [email, fullName, phoneNo];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'fullName': fullName,
      'uid': uid,
      'phoneNo': phoneNo,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      email: map['email'] != null ? map['email'] as String : null,
      fullName: map['fullName'] != null ? map['fullName'] as String : null,
      uid: map['uid'] != null ? map['uid'] as String : null,
      phoneNo: map['phoneNo'] != null ? map['phoneNo'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
