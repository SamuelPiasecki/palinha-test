import 'package:flutter/material.dart';
import 'package:palinha_test/src/modules/home/data/http/http_client.dart';
import 'package:palinha_test/src/modules/home/data/repositories/user_repository.dart';
import 'package:palinha_test/src/modules/home/store/user_store.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final UserStore store =
      UserStore(repository: UserRepository(client: HttpClient()));

  @override
  void initState() {
    super.initState();
    store.getUsers();
    print(store);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AnimatedBuilder(
            animation:
                Listenable.merge([store.isLoading, store.error, store.state]),
            builder: (context, child) {
              if (store.isLoading.value) {
                return Center(
                  child: CircularProgressIndicator(
                    color: Color(0xFF005C78),
                  ),
                );
              }
              if (store.error.value.isNotEmpty) {
                return Center(child: Text(store.error.value));
              }
              if (store.state.value.isEmpty) {
                return const Center(
                  child: Text('Nenhum item na lista'),
                );
              } else {
                return ListView.separated(
                    separatorBuilder: (context, index) => const SizedBox(
                          height: 8,
                        ),
                    itemCount: store.state.value.length,
                    itemBuilder: (_, index) {
                      final item = store.state.value[index];
                      return Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: ListTile(
                              leading: ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Image.network(
                                    item.avatar,
                                    fit: BoxFit.cover,
                                  )),
                              contentPadding: EdgeInsets.zero,
                              title: Text(
                                item.name,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.phone_outlined),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        item.phone,
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 18),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    'Idade: ${item.age.toString()}',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      );
                    });
              }
            }));
  }
}
