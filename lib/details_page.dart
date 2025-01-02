import 'package:flutter/material.dart';
import 'package:myapp/edit_todo_page.dart';
import 'package:intl/intl.dart';
import 'package:myapp/hive_model.dart';
class DetailsPage extends StatelessWidget {
  final Todo todo;

  DetailsPage({required this.todo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(todo.title),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            Text(
              "Description:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(todo.description),

            SizedBox(height: 16),

            Text(
              "Date:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(DateFormat.yMMMd().format(todo.dateTime)),

            Spacer(),

            // Edit button in the body
            ElevatedButton(
              onPressed: () {
                // Navigate to EditTodoPage for editing the note
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditTodoPage(todo: todo),
                  ),
                );
              },
              child: Text("Edit Note"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFFF7900),
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
