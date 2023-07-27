import 'package:flutter_bloc_sqlite/domain/models/todo.dart';

abstract class TodoRepository {
  Future<List<Todo>> getTodos();
  Future<Todo> addTodo(Todo todo);
  Future<Todo> updateTodo(Todo todo);
  Future<Todo> deleteTodo(int id);
}