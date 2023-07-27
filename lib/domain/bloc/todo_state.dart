import 'package:flutter/foundation.dart';

import '../models/todo.dart';

@immutable
abstract class TodoState {
  const TodoState();
}

class TodoInitial extends TodoState {}

class TodoPageLoading extends TodoState {}

class TodoPageLoaded extends TodoState {
  final List<Todo> todos;
  const TodoPageLoaded({this.todos = const <Todo>[]});
}

class TaskError extends TodoState {
  final String? message;
  const TaskError(this.message);
}