import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  // final String uid;
  final String name;
  final String email;
  final Timestamp createdAt;

  const UserModel({
    // required this.uid,
    required this.name,
    required this.email,
    required this.createdAt,
  });

  /// Converts this UserModel instance to a map.
  Map<String, dynamic> toMap() {
    return {
      // 'uid': uid,
      'name': name,
      'email': email,
      'createdAt': createdAt,
    };
  }

  /// Creates a UserModel instance from a map.
  factory UserModel.  fromMap(Map<String, dynamic> map) {
    return UserModel(
      // uid: map['uid'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      createdAt: map['createdAt'] as Timestamp,
    );
  }
}
