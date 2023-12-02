import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fbAuth;

import '../models/custom_error.dart';

class AuthRepository {
  final FirebaseFirestore firebaseFirestore;
  final fbAuth.FirebaseAuth firebaseAuth;
  AuthRepository({
    required this.firebaseFirestore,
    required this.firebaseAuth,
  });
  final usersRef = FirebaseFirestore.instance.collection('users');
  Stream<fbAuth.User?> get user => firebaseAuth.userChanges();
  String? get currentUserId => firebaseAuth.currentUser?.uid;

  Future<void> signup({
    required String fullName,
    required String email,
    required String password,
    required int phoneNumber,
  }) async {
    try {
      final fbAuth.UserCredential userCredential =
          await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final signedInUser = userCredential.user!;
      print('signInUser $signedInUser');

      await usersRef.doc(signedInUser.uid).set({
        'fullName': fullName,
        'email': email,
        'phoneNumber': phoneNumber,
      });
    } on fbAuth.FirebaseAuthException catch (e) {
      throw CustomError(
        code: e.code,
        message: e.message!,
        plugin: e.plugin,
      );
    } catch (e) {
      throw CustomError(
        code: 'Exception',
        message: e.toString(),
        plugin: 'flutter_error/server_error',
      );
    }
  }

  Future<void> signin({
    required String email,
    required String password,
  }) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on fbAuth.FirebaseAuthException catch (e) {
      throw CustomError(
        code: e.code,
        message: e.message!,
        plugin: e.plugin,
      );
    } catch (e) {
      throw CustomError(
        code: 'Exception',
        message: e.toString(),
        plugin: 'flutter_error/server_error',
      );
    }
  }

  Future<void> signout() async {
    await firebaseAuth.signOut();
  }
}
