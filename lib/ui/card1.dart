import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:td2_2223/models/task.dart';

class Ecran1 extends StatefulWidget {
  @override
  _Ecran1State createState() => _Ecran1State();
}

class _Ecran1State extends State<Ecran1> {
  late List<Task> tasks = Task.generateTask(50);
  String title = '';
  String tags = '';

  void _addTask() {
    final newTask = Task(
      title: title,
      tags: tags.split(' '),
      id: tasks.length + 1,
      nbhours: 0,
      difficulty: 0,
      description: '',
    );
    setState(() {
      tasks.add(newTask);
    });
    title = '';
    tags = '';
  }

  void _deleteTask(Task task) {
    setState(() {
      tasks.remove(task);
    });
  }

  void _updateTask(Task task, String newTitle, List<String> newTags) {
    setState(() {
      task.title = newTitle;
      task.tags = newTags;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
          ),
          SizedBox(height: 16),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: tasks.length,
            itemBuilder: (context, index) => Card(
              elevation: 6,
              margin: const EdgeInsets.all(10),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.lightBlue,
                  child: Text(tasks[index].id.toString()),
                ),
                title: Text(tasks[index].title),
                subtitle: Text(tasks[index].tags.join(" ")),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            String newTitle = tasks[index].title;
                            List<String> newTags = tasks[index].tags;
                            return AlertDialog(
                              title: Text('Modifier la tâche'),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextFormField(
                                    initialValue: tasks[index].title,
                                    decoration: InputDecoration(
                                      labelText: 'Titre de la tâche',
                                    ),
                                    onChanged: (value) {
                                      newTitle = value;
                                    },
                                  ),
                                  TextFormField(
                                    initialValue: tasks[index].tags.join(" "),
                                    decoration: InputDecoration(
                                      labelText: 'Description de la tâche',
                                    ),
                                    onChanged: (value) {
                                      newTags = value.split(' ');
                                    },
                                  ),
                                ],
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text('Annuler'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    _updateTask(
                                        tasks[index], newTitle, newTags);
                                    Navigator.pop(context);
                                  },
                                  child: Text('Enregistrer'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      icon: Icon(Icons.edit),
                    ),
                    IconButton(
                      onPressed: () {
                        _deleteTask(tasks[index]);
                      },
                      icon: Icon(Icons.delete),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
