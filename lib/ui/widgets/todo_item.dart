import 'package:flutter/material.dart';

import '../../domain/models/todo.dart';

class TodoItem extends StatelessWidget {
  final Todo todo;
  final ValueChanged? callback;
  const TodoItem(this.todo, this.callback, {super.key});

  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CheckboxListTile(value: todo.done.isEven? false: true, onChanged: callback),
        Text(todo.title)
    ],);
  }
}