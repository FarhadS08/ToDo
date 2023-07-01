import 'package:flutter/material.dart';
import 'package:list_manipulation/services/firestore.dart';
import 'package:list_manipulation/widgets/list_tile.dart';
import 'package:provider/provider.dart';
import '../models/list.dart';

class ListViewWidget extends StatelessWidget {
  final String
      userId;

  ListViewWidget({required this.userId}) {
    print('UserID: $userId'); // print the userId for debugging
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FirestoreService>(builder: (context, firestore, child) {
      return StreamBuilder<List<TodoModel>>(
        stream: Provider.of<FirestoreService>(context, listen: false)
            .getTodos(userId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            print(snapshot.error);
            return const Center(child: Text('An error occurred'));
          } else {
            List<TodoModel> todos = snapshot.data!;
            return ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) {
                return CustomTile(
                  userId: userId,
                  id: todos[index].id,
                  title: todos[index].text,
                  onpressed: (){
                    firestore.removeTodo(userId, todos[index].id);
                  },
                );
              },
            );
          }
        },
      );
    });
  }
}
