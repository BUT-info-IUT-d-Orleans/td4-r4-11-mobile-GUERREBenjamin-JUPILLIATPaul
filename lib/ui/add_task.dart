import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:td2_2223/ui/slider_difficulty.dart';

import '../models/task.dart';
import '../view_models/task_view_model.dart';

class AddTask extends StatefulWidget {
  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final _formKey = GlobalKey<FormState>();
  late String _title;
  late int _nbhours;
  late double _difficulty = 0.0;
  late String _description;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Task'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
                onSaved: (value) {
                  _title = value!;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(labelText: 'Number of hours'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the number of hours';
                  }
                  return null;
                },
                onSaved: (value) {
                  _nbhours = int.parse(value!);
                },
              ),
              const SizedBox(height: 16),
              SliderDifficulty(
                value: _difficulty.clamp(1, 5),
                label: 'Difficulty',
                onChanged: (value) {
                  setState(() {
                    _difficulty = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Description'),
                maxLines: null,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
                onSaved: (value) {
                  _description = value!;
                },
              ),
              SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    int idMax = context.read<TaskViewModel>().getMaxId() + 1;
                    final task = Task(
                      id: idMax,
                      title: _title,
                      tags: [],
                      nbhours: _nbhours,
                      difficulty: _difficulty.toInt(),
                      description: _description,
                    );
                    context.read<TaskViewModel>().addTask(task);
                    Navigator.pop(context);
                  }
                },
                child: Text('Add Task'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
