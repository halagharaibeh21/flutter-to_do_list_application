import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:myapp/details_page.dart';
import 'package:myapp/edit_todo_page.dart';
import 'package:myapp/settings_page.dart';
import 'package:myapp/hive_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Box<Todo> todoBox;

  @override
  void initState() {
    super.initState();
    todoBox = Hive.box<Todo>("todo");
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('To do'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsPage()),
              );
            },
          ),
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: todoBox.listenable(),
        builder: (context, Box<Todo> box, _) {
          return ListView.builder(
            itemCount: box.length,
            itemBuilder: (context, index) {
              Todo todo = box.getAt(index)!;

              return Container(
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: todo.isCompleted
                      ? const Color(0xFFC4E4CC) // Darker green for completed
                      : todo.isInProgress
                          ? const Color(0xFFB0D7F8) // Darker blue for in-progress
                          : const Color(0xFFFFD2A0), // Warm pastel orange for default
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailsPage(todo: todo),
                      ),
                    );
                  },
                  title: Text(
                    todo.title,
                    style: TextStyle(
                      decoration: todo.isCompleted
                          ? TextDecoration.lineThrough
                          : null,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    todo.description,
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  trailing: PopupMenuButton<String>(
                    icon: Icon(
                      Icons.more_vert,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.black // Black for dark mode
                          : Colors.grey, // Default for light mode
                    ),
                    onSelected: (value) async {
                      if (value == 'Delete' && todo.isInBox) {
                        await todo.delete();
                      } else if (value == 'In Progress') {
                        setState(() {
                          todo.isInProgress = true;
                          todo.isCompleted = false;
                        });
                      } else if (value == 'Completed') {
                        setState(() {
                          todo.isCompleted = true;
                          todo.isInProgress = false;
                        });
                      } else if (value == 'Edit') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditTodoPage(todo: todo),
                          ),
                        );
                      }
                    },
                    itemBuilder: (context) => [
                      const PopupMenuItem(
                        value: 'In Progress',
                        child: Text('Mark as In Progress'),
                      ),
                      const PopupMenuItem(
                        value: 'Completed',
                        child: Text('Mark as Completed'),
                      ),
                      const PopupMenuItem(
                        value: 'Edit',
                        child: Text('Edit'),
                      ),
                      const PopupMenuItem(
                        value: 'Delete',
                        child: Text('Delete'),
                      ),
                    ],
                  ),
                  leading: Checkbox(
                    value: todo.isCompleted,
                    onChanged: (value) {
                      setState(() {
                        todo.isCompleted = value!;
                        todo.isInProgress = !value;
                        todo.save();
                      });
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addTodoDialog(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _addTodoDialog(BuildContext context) {
    final TextEditingController _titleController = TextEditingController();
    final TextEditingController _descController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Add Task"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: "Title"),
            ),
            TextField(
              controller: _descController,
              decoration: const InputDecoration(labelText: "Description"),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              _addTodo(_titleController.text, _descController.text);
              Navigator.pop(context);
            },
            child: const Text("Add"),
          ),
        ],
      ),
    );
  }

  void _addTodo(String title, String description) {
    if (title.isNotEmpty) {
      todoBox.add(
        Todo(
          title: title,
          description: description,
          dateTime: DateTime.now(),
        ),
      );
    }
  }
}
