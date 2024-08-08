import 'dart:convert';
import 'dart:typed_data';

import 'package:palinha_test/src/modules/main/data/http/exceptions.dart';
import 'package:palinha_test/src/modules/main/data/http/http_client.dart';
import 'package:palinha_test/src/modules/task/data/models/task_model.dart';

abstract class ITaskRepository {
  Future<List<Task>> getTasks();
  Future<void> postTask(Task task);
  Future<void> deleteTask(String id);
}

class TaskRepository implements ITaskRepository {
  final IHttpClient client;

  TaskRepository({required this.client});

  String fixEncoding(String text) {
    final bytes = Uint8List.fromList(text.codeUnits);
    return utf8.decode(bytes, allowMalformed: true);
  }

  String translatePriority(String priority) {
    switch (priority) {
      case "low":
        return "Baixa";
      case "medium":
        return "Média";
      case "high":
        return "Alta";
      case "urgent":
        return "Urgente";
    }
    return "";
  }

  @override
  Future<List<Task>> getTasks() async {
    final response = await client.get(
        url: 'https://66aaa1ee636a4840d7c83938.mockapi.io/api/test/tasks');

    if (response.statusCode == 200) {
      final List<dynamic> body = jsonDecode(response.body);

      final List<Task> tasks = body.map((item) {
        final title = fixEncoding(item['title']);
        final description = fixEncoding(item['description']);
        return Task(
            title: title,
            description: description,
            priority: translatePriority(item['priority']!),
            dueDate: item['dueDate'],
            id: item['id']);
      }).toList();

      return tasks;
    } else if (response.statusCode == 404) {
      throw NotFoundException("A url informada não é válida");
    } else {
      throw Exception("Não foi possível carregar as tarefas");
    }
  }

  @override
  Future<void> postTask(Task task) async {
    final response = await client.post(
        url: 'https://66aaa1ee636a4840d7c83938.mockapi.io/api/test/tasks',
        body: jsonEncode({
          'title': task.title,
          'description': task.description,
          'priority': task.priority,
          'dueDate': task.dueDate
        }));

    if (response.statusCode != 201) {
      throw Exception("Não foi possível criar a tarefa");
    }
  }

  @override
  Future<void> deleteTask(String id) async {
    final url =
        'https://66aaa1ee636a4840d7c83938.mockapi.io/api/test/tasks/$id';

    final response = await client.delete(
      url: url,
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete task: ${response.reasonPhrase}');
    }
  }
}
