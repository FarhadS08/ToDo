import 'package:cloud_firestore/cloud_firestore.dart';

class TodoModel {
  String userId;
  String id;
  String text;
  bool isDone;

  TodoModel({required this.userId, required this.id, required this.isDone, required this.text});

  // Send data to firestore with map
  Map<String, dynamic> toMap() {
    return {
      'isDone': isDone,
      'text': text,
      'userId': userId,
    };
  }

  // Retrieve data from firestore
  factory TodoModel.fromDocument(DocumentSnapshot doc) {
    try {
      var data = doc.data() as Map<String, dynamic>;
      return TodoModel(
        id: doc.id,
        text: data['text'] ?? '',
        isDone: data['isDone'] ?? false,
        userId: data['userId'] ?? '',
      );
    } catch (e) {
      print('Error creating TodoModel from Document: $e');
      throw e;
    }
  }


}
