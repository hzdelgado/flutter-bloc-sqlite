import 'package:flutter/material.dart';
import 'package:flutter_bloc_sqlite/domain/models/todo.dart';

class TodoInputField extends StatelessWidget {
  final Function onItemAdded;
  final TextEditingController inputController = TextEditingController();
  TodoInputField(this.onItemAdded, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(30),
        child: TextField(
          controller: inputController,
          onSubmitted: (value) {
            var todo = Todo(title: value);
            onItemAdded(todo);
          },
          decoration: InputDecoration(
              hintText: "Enter task here",
              hintStyle: const TextStyle(
                color: Colors.deepPurple,
                fontSize: 18,
              ),
              suffixIcon: IconButton(
                icon: const Icon(Icons.cancel, color: Colors.deepPurple,),
                onPressed: () => inputController.clear(),
              )),
        ));
  }
}
