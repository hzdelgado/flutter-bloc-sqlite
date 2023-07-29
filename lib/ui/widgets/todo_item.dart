import 'package:flutter/material.dart';

import '../../domain/models/todo.dart';

class TodoItem extends StatelessWidget {
  final Todo todo;
  final ValueChanged? onChanged;
  final DismissDirectionCallback onDeleted;
  const TodoItem(this.todo, this.onChanged, this.onDeleted, {super.key});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
  key: Key(todo.id.toString()),
  background: Container(color: Colors.red),
  direction: DismissDirection.endToStart,
  onDismissed: onDeleted,
  child: SizedBox(
        width: MediaQuery.sizeOf(context).width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: CheckboxListTile(
                    value: todo.done.isEven ? false : true,
                    onChanged: onChanged)),
            Expanded(flex: 3, child: Text(todo.title))
          ],
        )));
  }
}
