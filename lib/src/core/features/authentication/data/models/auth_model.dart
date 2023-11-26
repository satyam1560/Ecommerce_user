// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class UserDetails extends Equatable {
  final String? fullName;
  final String? email;
  final String? password;
  final int? phoneNumber;
  final String? uid;
  const UserDetails({
    this.fullName,
    this.email,
    this.password,
    this.phoneNumber,
    this.uid,
  });

  // UserDetails copyWith({
  //   String? fullName,
  //   String? email,
  //   String? password,
  //   int? phoneNumber,
  //   String? uid,
  // }) {
  //   return UserDetails(
  //     fullName: fullName ?? this.fullName,
  //     email: email ?? this.email,
  //     password: password ?? this.password,
  //     phoneNumber: phoneNumber ?? this.phoneNumber,
  //     uid: uid ?? this.uid,
  //   );
  // }

  // Map<String, dynamic> toMap() {
  //   return <String, dynamic>{
  //     'fullName': fullName,
  //     'email': email,
  //     'password': password,
  //     'phoneNumber': phoneNumber,
  //     'uid': uid,
  //   };
  // }

  factory UserDetails.fromDoc(DocumentSnapshot userDoc) {
    final userData = userDoc.data() as Map<String, dynamic>?;

    return UserDetails(
      fullName: userData!['fullName'],
      email: userData['email'],
      password: userData['password'],
      phoneNumber: userData['phoneNumber'],
      uid: userDoc.id,
    );
  }

  factory UserDetails.initialUserDetails() {
    return const UserDetails(
      fullName: '',
      email: '',
      password: '',
      phoneNumber: 0,
      uid: '',
    );
  }

  // factory UserDetails.fromMap(Map<String, dynamic> map) {
  //   return UserDetails(
  //     fullName: map['fullName'] != null ? map['fullName'] as String : null,
  //     email: map['email'] != null ? map['email'] as String : null,
  //     // password: map['password'] != null ? map['password'] as String : null,
  //     phoneNumber:
  //         map['phoneNumber'] != null ? map['phoneNumber'] as int : null,
  //     uid: map['uid'] != null ? map['uid'] as String : null,
  //   );
  // }

  @override
  List<Object?> get props => [
        fullName,
        email,
        password,
        phoneNumber,
        uid,
      ];

  @override
  String toString() {
    return 'User(uid: $uid, fullName: $fullName, email: $email,phoneNumber:$phoneNumber)';
  }

  // String toJson() => json.encode(toMap());

  // factory UserDetails.fromJson(String source) =>
  //     UserDetails.fromMap(json.decode(source) as Map<String, dynamic>);
}
