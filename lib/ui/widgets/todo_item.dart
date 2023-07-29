import 'package:flutter/material.dart';

import '../../domain/models/todo.dart';

class TodoItem extends StatelessWidget {
  final Todo todo;
  final ValueChanged? onChanged;
  final DismissDirectionCallback onDeleted;
  final Function? showEditDialog;
  const TodoItem(this.todo, this.onChanged, this.onDeleted, this.showEditDialog,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
        key: UniqueKey(),
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
                Expanded(
                    flex: 2,
                    child: Text(
                      todo.title,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: todo.done.isEven
                              ? Colors.black.withOpacity(.7)
                              : Colors.grey),
                    )),
                Expanded(
                    child: IconButton(
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.grey,
                        ),
                        onPressed: () => showEditDialog!(todo.id)))
              ],
            )));
  }
}
