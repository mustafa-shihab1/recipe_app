import 'package:cloud_firestore/cloud_firestore.dart';

import '../../features/auth/data/models/user_model.dart';

class FirestoreService {
  static const String usersCollection = 'users';

  // Add your methods to interact with Firestore here
  static saveUserData(String userId, Map<String, dynamic> data) {
    // Implementation to save user data to Firestore
    FirebaseFirestore.instance
        .collection(usersCollection)
        .doc(userId)
        .set(data);
  }
  // static fetchUserData(String userId)  async{
  //   // Implementation to fetch user data from Firestore
  //    DocumentSnapshot doc = await FirebaseFirestore.instance
  //       .collection(usersCollection)
  //       .doc(userId)
  //       .get();
  //   if(doc.exists){
  //     var data = doc.data() as Map<String, dynamic>;
  //     var userModel= UserModel.fromMap(data);
  //     return userModel;
  //   } else {
  //     return Exception('User Data not found');
  //   }
  // }
  //
  // static updateUserData(UserModel newUserModel, String userId) async{
  //   await FirebaseFirestore.instance.collection(usersCollection).doc(userId).update(newUserModel.toMap());
  // }
}
