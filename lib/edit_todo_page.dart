import 'package:flutter/material.dart';
//import 'package:myapp/main.dart';
import 'package:myapp/hive_model.dart';
class EditTodoPage extends StatefulWidget {
  final Todo todo;

  EditTodoPage({required this.todo});

  @override
  _EditTodoPageState createState() => _EditTodoPageState();
}

class _EditTodoPageState extends State<EditTodoPage> {
  late TextEditingController _titleController;
  late TextEditingController _descController;

  @override
  void initState() {
    super.initState();
    // Initialize controllers with the current to-do's data
    _titleController = TextEditingController(text: widget.todo.title);
    _descController = TextEditingController(text: widget.todo.description);
  }

  @override
  void dispose() {
    // Dispose controllers to free up resources
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  void _saveTodo() {
    // Update the todo and save it to Hive
    setState(() {
      widget.todo.title = _titleController.text;
      widget.todo.description = _descController.text;
      widget.todo.save();
    });

    // Go back to the previous screen
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.todo.title),
        backgroundColor: theme.appBarTheme.backgroundColor,
        foregroundColor: theme.appBarTheme.foregroundColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: "Title",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _descController,
              decoration: InputDecoration(
                labelText: "Description",
                border: OutlineInputBorder(),
              ),
              maxLines: 5,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _saveTodo,
              child: Text("Save"),
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.floatingActionButtonTheme.backgroundColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
//progrss, completed change color 
//log in with user + with history 
//with data 
