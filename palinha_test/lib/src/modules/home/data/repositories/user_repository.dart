import 'dart:convert';

import 'package:palinha_test/src/modules/main/data/http/exceptions.dart';
import 'package:palinha_test/src/modules/main/data/http/http_client.dart';
import 'package:palinha_test/src/modules/home/data/models/user_model.dart';

abstract class IUserRepository {
  Future<List<User>> getUsers();
}

class UserRepository implements IUserRepository {
  final IHttpClient client;

  UserRepository({required this.client});

  @override
  Future<List<User>> getUsers() async {
    final response = await client.get(
        url: 'https://66b3cb767fba54a5b7ee35a9.mockapi.io/api/test/users');

    if (response.statusCode == 200) {
      final List<User> users = [];

      final body = jsonDecode(response.body);

      body.map((item) {
        final User user = User.fromMap(item);
        users.add(user);
      }).toList();

      return users;
    } else if (response.statusCode == 404) {
      throw NotFoundException("A url informada não é válida");
    } else {
      throw Exception("Não foi possível carregar os usuários");
    }
  }
}
