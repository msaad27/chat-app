import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User?> login(String email, String pass) async {
    try {
      UserCredential userCred = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: pass.trim(),
      );
      return userCred.user;
    } catch (e) {
      rethrow; 
    }
  }

  /// Register user safely
  Future<User?> signUp(String email, String password, String name) async {
    try {
      UserCredential userCred = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      final createdUser = userCred.user;
      if (createdUser == null) {
        throw Exception('Failed to create user');
      }

      String uid = createdUser.uid;

      await _firestore.collection('users').doc(uid).set({
        'uid': uid,
        'name': name.trim(),
        'email': email.trim(),
        'profilePic': '',
        'about': '',
      });

      return userCred.user;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
