import 'package:api_project/screens/add_task_screen.dart';
import 'package:flutter/material.dart';
import '../service/api_service.dart';
import '../models/task.dart';

class TaskListScreen extends StatefulWidget {
  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  final ApiService apiService = ApiService();
  late Future<List<Task>> tasks;

  @override
  void initState() {
    super.initState();
    tasks = apiService.getTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.large(
          child: Row(
            children: [Icon(Icons.add), Text('Add Task')],
          ),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => AddTaskScreen()));
          }),
      appBar: AppBar(title: Text("Task List")),
      body: FutureBuilder<List<Task>>(
        future: tasks,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No tasks found.'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Task task = snapshot.data![index];
                return ListTile(
                  title: Text(task.title),
                  trailing: Checkbox(
                    value: task.completed,
                    onChanged: (value) {
                      // Handle task completion status change
                    },
                  ),
                  onTap: () {
                    // Handle task selection
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
