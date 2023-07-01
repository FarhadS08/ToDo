import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:list_manipulation/services/firestore.dart';
import 'package:provider/provider.dart';

import '../models/list.dart';

class CustomTile extends StatefulWidget {
  final String userId;
  final String title;
  final VoidCallback onpressed;
  final String id;

  CustomTile({required this.title, required this.onpressed, required this.id, required this.userId});

  @override
  State<CustomTile> createState() => _CustomTileState();
}

class _CustomTileState extends State<CustomTile> {

  late TextEditingController _controller = TextEditingController(text: widget.title);
  String? newText;




  @override
  Widget build(BuildContext context) {
    return Consumer<FirestoreService>(
      builder: (context, firestore, child) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 5.0,
                  offset: Offset(0, 0),
                ),
              ],
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
              leading: Container(
                padding: EdgeInsets.only(right: 15.0),
                decoration: const BoxDecoration(
                  border: Border(
                    right: BorderSide(width: 1.0, color: Colors.black12),
                  ),
                ),
                child: Icon(Icons.task_alt_rounded,
                    color: Theme.of(context).primaryColor),
              ),
              title: GestureDetector(
                onTap: () async {
                  await showDialog(
                    context: context,
                    builder: (context) => SimpleDialog(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                          child: TextField(
                            controller: _controller,
                              onChanged: (value){
                                newText = value;
                              },
                            ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                          child: ElevatedButton(
                            onPressed: () {
                              print(widget.id);
                              firestore.updateTodo(widget.userId, widget.id, newText!);
                              Navigator.pop(context);
                            },
                            child: const Text('Add'),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                child: Text(
                  widget.title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              trailing: IconButton(
                onPressed: widget.onpressed,
                icon:
                    Icon(Icons.delete_rounded, color: Colors.black, size: 22.0),
              ),
            ),
          ),
        );
      },
    );
  }
}
