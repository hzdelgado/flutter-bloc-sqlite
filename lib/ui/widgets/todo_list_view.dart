import 'package:flutter/material.dart';
import 'package:flutter_bloc_sqlite/domain/models/todo.dart';
import 'package:flutter_bloc_sqlite/ui/widgets/todo_item.dart';

class TodoListView extends StatelessWidget {
  final List<Todo> todos;
  final Function valueChanged;
  const TodoListView(this.todos, this.valueChanged, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: todos.length, itemBuilder: (ctx, index) {
          return TodoItem(todos[index], (value) {
            var todo = todos[index].done = value? 1: 0;
            valueChanged(todo, index);
          });
        });
  }
}
