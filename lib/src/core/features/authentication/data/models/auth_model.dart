// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class UserDetails extends Equatable {
  String? fullName;
  String? email;
  String? password;
  int? phoneNumber;
  String? uid;
  UserDetails({
    this.fullName,
    this.email,
    this.password,
    this.phoneNumber,
    this.uid,
  });

  UserDetails copyWith({
    String? fullName,
    String? email,
    String? password,
    int? phoneNumber,
    String? uid,
  }) {
    return UserDetails(
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      password: password ?? this.password,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      uid: uid ?? this.uid,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'fullName': fullName,
      'email': email,
      'password': password,
      'phoneNumber': phoneNumber,
      'uid': uid,
    };
  }

  factory UserDetails.fromMap(Map<String, dynamic> map) {
    return UserDetails(
      fullName: map['fullName'] != null ? map['fullName'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
      phoneNumber:
          map['phoneNumber'] != null ? map['phoneNumber'] as int : null,
      uid: map['uid'] != null ? map['uid'] as String : null,
    );
  }

  @override
  List<Object?> get props => [
        fullName,
        email,
        password,
        phoneNumber,
        uid,
      ];

  String toJson() => json.encode(toMap());

  factory UserDetails.fromJson(String source) =>
      UserDetails.fromMap(json.decode(source) as Map<String, dynamic>);
}
