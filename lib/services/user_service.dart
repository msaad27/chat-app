import 'package:chat_app/Models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> updateAbout(String uid, String about) async {
    await _firestore.collection('users').doc(uid).update({'about': about});
  }

  Future<void> updateName(String uid, String name) async {
    await _firestore.collection('users').doc(uid).update({'name': name});
  }

  Future<UserModel?> getUser(String uid) async {
    final doc = await _firestore.collection('users').doc(uid).get();
    if (!doc.exists) return null;
    return UserModel.fromJson(doc.data()!);
  }

  Future<void> deleteUser(String uid) async {
    await _firestore.collection('users').doc(uid).delete();
  }
}
