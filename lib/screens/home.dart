import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:list_manipulation/services/firestore.dart';
import 'package:provider/provider.dart';
import '../services/auth.dart';
import '../widgets/list_widget.dart';
import '../models/list.dart';

class Home extends StatefulWidget {
  static String id = 'home';

  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late TodoModel todo;
  String? userId = FirebaseAuth.instance.currentUser?.uid;
  String? userEmail = FirebaseAuth.instance.currentUser?.email;

  @override
  Widget build(BuildContext context) {
    return Consumer<FirestoreService>(builder: (context, firestore, child) {
      return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => SimpleDialog(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    child: TextField(
                      textCapitalization: TextCapitalization.characters,
                      onChanged: (value) {
                        todo = TodoModel(
                            userId: userId!,
                            id: '',
                            text: value,
                            isDone: false);
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    child: ElevatedButton(
                      onPressed: () {
                        firestore.addTodo(userId!, todo);
                        Navigator.pop(context);
                      },
                      child: const Text('Add'),
                    ),
                  ),
                ],
              ),
            );
          },
          child: const Icon(Icons.add),
        ),
        appBar: AppBar(
          centerTitle: false,
          title: Text(
            userEmail.toString().split("@")[0] + "'s Todos",
            style: TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: GestureDetector(
                onTap: () async {
                  await Provider.of<Auth>(context, listen: false).signOut();
                },
                child: Icon(
                  Icons.logout_rounded,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
        body: ListViewWidget(userId: userId!),
      );
    });
  }
}
