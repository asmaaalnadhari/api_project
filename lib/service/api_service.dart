import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/task.dart';

class ApiService {
  final String baseUrl = "https://jsonplaceholder.typicode.com";

  // Create a new task (POST)
  Future<Task> createTask(Task task) async {

    print('jsonEncode : ${jsonEncode(task.toJson())}');
    print('toJson : ${task.toJson()}');
    final response = await http.post(
      Uri.parse('$baseUrl/todos'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(task.toJson()),
    );
    if (response.statusCode == 201) {
      return Task.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create task');
    }
  }

  // Read tasks (GET)
  Future<List<Task>> getTasks() async {
    final response = await http.get(Uri.parse('$baseUrl/todos'));
    if (response.statusCode == 200) {
      print('response.body : ${response.body}');
      print('jsonDecode : ${jsonDecode(response.body)}');
      List<dynamic> body = jsonDecode(response.body);
      return body.map((task) => Task.fromJson(task)).toList();
    } else {
      throw Exception('Failed to load tasks');
    }
  }

  // Update a task (PUT)
  Future<Task> updateTask(int id, Task task) async {
    final response = await http.put(
      Uri.parse('$baseUrl/todos/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(task.toJson()),
    );
    if (response.statusCode == 200) {
      return Task.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update task');
    }
  }

  // Delete a task (DELETE)
  Future<void> deleteTask(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/todos/$id'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete task');
    }
  }
}
