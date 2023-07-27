// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc_sqlite/domain/models/todo.dart';

abstract class TodoEvent {
  const TodoEvent();
}

class GetTodos extends TodoEvent {}

class LoadTodos extends TodoEvent {
  final List<Todo> todos;
  LoadTodos({
    this.todos = const <Todo>[],
  });
}

class AddTodo extends TodoEvent {
  final Todo todo;
  AddTodo({
    required this.todo,
  });
}

class UpdateTodo extends TodoEvent {
  final Todo todo;
  UpdateTodo({
    required this.todo,
  });
}

class DeleteTodo extends TodoEvent {
  final Todo todo;
  DeleteTodo({
    required this.todo,
  });
}
