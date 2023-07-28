import 'package:flutter/foundation.dart';

import '../models/todo.dart';

@immutable
abstract class TodoState {
  const TodoState();
}

class TodoPageLoading extends TodoState {}

class TodoPageLoaded extends TodoState {
  final List<Todo> todos;
  const TodoPageLoaded({this.todos = const <Todo>[]});
}

class TodoError extends TodoState {
  final String? message;
  const TodoError(this.message);
}