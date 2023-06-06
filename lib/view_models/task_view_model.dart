import 'package:flutter/material.dart';
import '../models/task.dart';

class TaskViewModel extends ChangeNotifier {
  late List<Task> liste; // late permet de ne pas initialiser la variable
  TaskViewModel() {
    liste = [];
  }
  void addTask(Task task) {
    liste.add(task);
    notifyListeners(); // permet de notifier les listeners
  }

  void generateTasks() {
    liste = Task.generateTask(50);
    notifyListeners(); // permet de notifier les listeners
  }

  int getMaxId() {
    int max = 0;
    for (var element in liste) {
      if (element.id > max) {
        max = element.id;
      }
    }
    return max;
  }
}
