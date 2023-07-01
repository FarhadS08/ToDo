import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:list_manipulation/screens/registration.dart';
import '../screens/home.dart';
import '../screens/login.dart';


class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.data?.uid == null) {
            return Registration();
          } else {
            return Home();
          }
        }
        return CircularProgressIndicator();  // Show loading screen while waiting for auth data
      },
    );
  }
}
