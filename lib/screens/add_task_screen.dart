import 'package:flutter/material.dart';

import '../models/task.dart';
import '../service/api_service.dart';

class AddTaskScreen extends StatefulWidget {
  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final ApiService apiService = ApiService();
  final TextEditingController _titleController = TextEditingController();
  bool _isCompleted = false;

  void _createTask() async {
    String title = _titleController.text;
    if (title.isNotEmpty) {
      Task newTask = Task(id: 0, title: title, completed: _isCompleted);
      try {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Added Successfully')));
        await apiService.createTask(newTask);
        Navigator.pop(context);
// Go back after creating task
      } catch (e) {
        // Handle error
        print("Error creating task: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Task")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Task Title'),
            ),
            CheckboxListTile(
              title: Text("Completed"),
              value: _isCompleted,
              onChanged: (value) {
                setState(() {
                  _isCompleted = value!;
                });
              },
            ),
            ElevatedButton(
              onPressed: _createTask,
              child: Text("Create Task"),
            ),
          ],
        ),
      ),
    );
  }
}
