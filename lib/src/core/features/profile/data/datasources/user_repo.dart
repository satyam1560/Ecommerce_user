import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_user/src/core/features/profile/data/models/user_model.dart';

class Userrepo {
  CollectionReference userdetails =
      FirebaseFirestore.instance.collection('users');

  Future<UserModel> getuserdetils({required String userId}) async {
    DocumentSnapshot user = await userdetails.doc(userId).get();
    Map<String, dynamic> userdata = user.data() as Map<String, dynamic>;
    UserModel usermodel = UserModel.fromMap(userdata);
    // print('userid${user.id}');
    usermodel.uid = user.id;
    return UserModel.fromMap(userdata);
  }
}
