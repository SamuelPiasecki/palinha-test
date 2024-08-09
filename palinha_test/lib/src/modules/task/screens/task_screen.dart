import 'package:flutter/material.dart';
import 'package:palinha_test/src/modules/main/data/http/http_client.dart';
import 'package:palinha_test/src/modules/task/data/repositories/task_repository.dart';
import 'package:palinha_test/src/modules/task/screens/widgets/task_modal.dart';
import 'package:palinha_test/src/modules/task/store/task_store.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  final TaskStore store =
      TaskStore(repository: TaskRepository(client: HttpClient()));

  @override
  void initState() {
    super.initState();
    store.getTasks();
  }

  void _reloadTasks() async {
    await Future.delayed(Duration(seconds: 5));
    await store.getTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(color: Color(0xFF508C9B)),
          child: AnimatedBuilder(
            animation:
                Listenable.merge([store.isLoading, store.error, store.state]),
            builder: (context, child) {
              if (store.isLoading.value) {
                return Center(
                  child: CircularProgressIndicator(
                    color: Color(0xFF134B70),
                  ),
                );
              }
              if (store.error.value.isNotEmpty) {
                _reloadTasks();
                return Center(child: Text(store.error.value));
              }
              if (store.state.value.isEmpty) {
                return const Center(
                  child: Text('Nenhuma tarefa na lista'),
                );
              } else {
                return ListView.separated(
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 4,
                  ),
                  itemCount: store.state.value.length,
                  itemBuilder: (_, index) {
                    final item = store.state.value[index];
                    return Column(
                      children: [
                        Container(
                          margin: EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Color(0xFFEEEEEE),
                            borderRadius: BorderRadius.circular(10),
                            border:
                                Border.all(color: Color(0xFF134B70), width: 3),
                          ),
                          child: ListTile(
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  item.title,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () async {
                                    await store.deleteTask(item.id);
                                    setState(() {
                                      store.state.value.removeWhere(
                                          (task) => task.id == item.id);
                                    });
                                  },
                                  icon: Icon(Icons.delete),
                                ),
                              ],
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.description,
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(item.dueDate),
                                    Text(
                                      item.priority,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              }
            },
          ),
        ),
        Positioned(
          bottom: 16.0,
          right: 16.0,
          child: FloatingActionButton(
            onPressed: () async {
              final task = await showTaskModal(context);
              if (task.title.isNotEmpty) {
                await store.postTask(task);
              }
            },
            child: Icon(
              Icons.add,
              color: Color(0xFFEEEEEE),
            ),
            backgroundColor: Color(0xFF134B70),
          ),
        ),
      ],
    );
  }
}
