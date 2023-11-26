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

/*
  Future<UserDetails> signup({required UserDetails userDetails}) async {
    try {
      final userCred = await _firebaseAuth.createUserWithEmailAndPassword(
          email: userDetails.email!, password: userDetails.password!);

      // Send email verification
      await userCred.user?.sendEmailVerification();

      // Update userDetails with the UID obtained during signup
      userDetails = userDetails.copyWith(uid: userCred.user?.uid);

      // Add user details to Firestore
      await userRef.add(userDetails.toMap());

      // Retrieve the signed-up user
      User signupUser = userCred.user!;
      return UserDetails(email: signupUser.email, uid: signupUser.uid);
    } on FirebaseAuthException catch (error) {
      if (error.code == 'email-already-in-use') {
        throw const Failure(message: 'Email is already in use.');
      } else if (error.code == 'wrong-password') {
        throw const Failure(message: 'Incorrect password.');
      } else {
        throw Failure(message: 'Authentication Error: ${error.message}');
      }
    } on PlatformException catch (error) {
      throw Failure(message: 'Database Error: ${error.message}');
    } catch (error) {
      throw Failure(message: error.toString());
    }
  }

  Future<UserDetails> login({required UserDetails userDetails}) async {
    try {
      final userCred = await _firebaseAuth.signInWithEmailAndPassword(
          email: userDetails.email!, password: userDetails.password!);

      _firebaseAuth.userChanges().listen((User? user) {
        if (user == null) {
          print('User is currently signed out!');
        } else {
          print('User is signed in!');
        }
      });

      // final bool isEmailVerified = userCred.user!.emailVerified;
      // print('Is email verified: $isEmailVerified');

      // final String authUid = userCred.user!.uid;
      // print('Auth UID: $authUid');

      // // Check if email is verified and auth UID matches UserDetails UID
      // if (!isEmailVerified) {
      //   // Resend email verification
      //   await userCred.user!.sendEmailVerification();
      //   throw const Failure(
      //       message: 'Email not verified. Verification email resent.');
      // }

      // if (authUid != userDetails.uid) {
      //   throw const Failure(message: 'Invalid credentials.');
      // }

      // // Retrieve user details from Firestore
      // QuerySnapshot data =
      //     await userRef.where('uid', isEqualTo: userDetails.uid).get();
      // print('--$data');
      // if (data.docs.isEmpty) {
      //   throw const Failure(message: 'User not found in Firestore.');
      // }

      // You can further validate other user details if needed
      // UserDetails userDetail = UserDetails.fromMap(data.docs.first.data() as Map<String, dynamic>);

      User signInUser = userCred.user!;
      print('User login credentials: $signInUser');
      return UserDetails(email: signInUser.email, uid: signInUser.uid);
    } on FirebaseAuthException catch (error) {
      throw Failure(message: 'Authentication Error: ${error.toString()}');
    } on PlatformException catch (error) {
      throw ('Database Error: ${error.toString()}');
    } catch (error) {
      throw (error.toString());
    }
  }

/*
  Future<UserDetails> login({required UserDetails userDetails}) async {
    try {
      final userCred = await _firebaseAuth.signInWithEmailAndPassword(
          email: userDetails.email!, password: userDetails.password!);

      final bool isEmailVaried = userCred.user!.emailVerified;
      print('is email varified $isEmailVaried');

      final String authuid = userCred.user!.uid;
      print('authuid-$authuid');

      QuerySnapshot data = await userRef.get();
      print('data.docs---${data.docs}');
      for (var doc in data.docs) {
        UserDetails userDetail =
            UserDetails.fromMap(doc.data() as Map<String, dynamic>);
        print('uid fiels${userDetail.uid}');
      }

      User signinUser = userCred.user!;
      print('userloginCred--${userCred.user}');
      return UserDetails(email: signinUser.email, uid: signinUser.uid);
    } on FirebaseAuthException catch (error) {
      throw Failure(message: 'Authentication Error: ${error.toString()}');
    } on PlatformException catch (error) {
      throw ('Database Error: ${error.toString()}');
    } catch (error) {
      throw (error.toString());
    }
  }
 */
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }*/

