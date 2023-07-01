import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:list_manipulation/services/AuthWrapper.dart';
import 'package:list_manipulation/services/auth.dart';
import 'package:list_manipulation/services/firestore.dart';
import 'package:provider/provider.dart';
import 'screens/registration.dart';
import 'screens/login.dart';
import 'screens/home.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Auth()),
        ChangeNotifierProvider(create: (context) => FirestoreService()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: AuthWrapper(),
      routes: {
        Login.id: (context) => Login(),
        Registration.id: (context) => Registration(),
        Home.id: (context) => Home(),
      },
    );
  }
}
