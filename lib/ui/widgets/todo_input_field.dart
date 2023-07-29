import 'package:flutter/material.dart';
import 'package:flutter_bloc_sqlite/domain/models/todo.dart';

class TodoInputField extends StatelessWidget {
  final Function onItemAdded;
  const TodoInputField(this.onItemAdded, {super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onSubmitted: (value) {
        var todo = Todo(title: value);
        onItemAdded(todo);
      },
      decoration: const InputDecoration(
          hintText: "Enter task here",
          hintStyle: TextStyle(
            color: Colors.lightBlue,
          )),
    );
  }
}
