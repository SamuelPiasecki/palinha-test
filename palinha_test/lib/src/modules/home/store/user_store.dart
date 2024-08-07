import 'package:flutter/material.dart';
import 'package:palinha_test/src/modules/home/data/http/exceptions.dart';
import 'package:palinha_test/src/modules/home/data/models/user_model.dart';
import 'package:palinha_test/src/modules/home/data/repositories/user_repository.dart';

class UserStore {
  final IUserRepository repository;

  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
  final ValueNotifier<List<User>> state = ValueNotifier<List<User>>([]);
  final ValueNotifier<String> error = ValueNotifier<String>('');

  UserStore({required this.repository});

  Future getUsers() async {
    isLoading.value = true;
    try {
      final result = await repository.getUsers();
      state.value = result;
    } on NotFoundException catch (e) {
      error.value = e.message;
    } catch (e) {
      error.value = e.toString();
    }
    isLoading.value = false;
  }
}
