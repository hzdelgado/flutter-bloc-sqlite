import 'package:flutter/material.dart';
import 'package:flutter_bloc_sqlite/domain/models/todo.dart';
import 'package:flutter_bloc_sqlite/ui/widgets/todo_item.dart';

class TodoListView extends StatelessWidget {
  final List<Todo> todos;
  final Function valueChanged;
  final Function valueDeleted;
  const TodoListView(this.todos, this.valueChanged, this.valueDeleted, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        itemCount: todos.length,
        itemBuilder: (ctx, index) {
          return TodoItem(todos[index], (value) {
            var todo = todos[index].copyWith(done: value? 1: 0);
            valueChanged(todo, index);
          }, (direction) {
            var todo = todos[index];
            valueDeleted(todo);
          });
        });
  }
}
