import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user.dart';

class Auth extends ChangeNotifier {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  UserModel? user;

  // Sign Up User
  Future<UserModel?> signUp(String email, String password) async {
    try {
      UserCredential userCredential =
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user != null) {
        user = UserModel(
          email: userCredential.user!.email!,
          uid: userCredential.user!.uid,
        );

        await _firestore.collection('users').add({
          'email': user?.email,
          'uid': user?.uid,
        });
      }
      notifyListeners();
      return user;
    } catch (e) {
      print(e);
    }
    return null;
  }

  // Sign In User
  Future<UserModel?> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user != null) {
        DocumentSnapshot documentSnapshot = await _firestore.collection('users')
            .doc(userCredential.user!.uid).get();

        if(documentSnapshot.exists){
          user = UserModel(
            email: userCredential.user!.email!,
            uid: userCredential.user!.uid,
          );
        }
      }
      notifyListeners();
      return user;
    } catch (e) {
      print(e);
    }
    return null;
  }

  // Sign Out User
  Future<void> signOut() async {
    _auth.signOut();
    notifyListeners();
  }

}
