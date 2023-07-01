import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import '../models/list.dart';

class FirestoreService extends ChangeNotifier {

  Future<void> updateTodo(String userId, String id, String text) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('todos')
          .doc(id)
          .update({'text': text});
      print('Todo updated successfully');
      notifyListeners();
    } catch (e) {
      print('Error adding todo: $e');
      throw e;
    }
  }


  Future<void> addTodo(String userId, TodoModel todo) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('todos')
          .add(todo.toMap());
      notifyListeners();
    } catch (e) {
      print('Error adding todo: $e');
      throw e;
    }
  }

  Stream<List<TodoModel>> getTodos(String userId) {
    try {
      return FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('todos')
          .snapshots()
          .map((QuerySnapshot snapshot) =>
              snapshot.docs.map((doc) => TodoModel.fromDocument(doc)).toList());
    } catch (e) {
      print('Error getting todos: $e');
      throw e;
    }
  }

  Future<void> removeTodo(String userId, String id) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('todos')
          .doc(id)
          .delete();
    } catch (e) {
      throw e;
    }
    notifyListeners();
  }
}
