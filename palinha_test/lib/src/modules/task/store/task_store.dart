import 'package:flutter/material.dart';
import 'package:palinha_test/src/modules/main/data/http/exceptions.dart';
import 'package:palinha_test/src/modules/task/data/models/task_model.dart';
import 'package:palinha_test/src/modules/task/data/repositories/task_repository.dart';

class TaskStore {
  final ITaskRepository repository;

  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
  final ValueNotifier<List<Task>> state = ValueNotifier<List<Task>>([]);
  final ValueNotifier<String> error = ValueNotifier<String>('');

  TaskStore({required this.repository});

  Future getTasks() async {
    isLoading.value = true;
    try {
      final result = await repository.getTasks();
      state.value = result;
    } on NotFoundException catch (e) {
      error.value = e.message;
    } catch (e) {
      error.value = e.toString();
    }
    isLoading.value = false;
  }

  Future postTask(Task task) async {
    try {
      await repository.postTask(task);
      await getTasks();
    } catch (e) {
      error.value = e.toString();
    }
  }

  Future deleteTask(String? id) async {
    try {
      if (id != null) {
        await repository.deleteTask(id);
      }
    } catch (e) {
      error.value = e.toString();
    }
  }
}
