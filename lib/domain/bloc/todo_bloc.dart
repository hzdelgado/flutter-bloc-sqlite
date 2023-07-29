// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'dart:async';

import 'package:flutter_bloc_sqlite/domain/bloc/todo_event.dart';
import 'package:flutter_bloc_sqlite/domain/bloc/todo_state.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc_sqlite/domain/models/todo.dart';
import 'package:flutter_bloc_sqlite/domain/repositories/todo_repository.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoRepository _repository;
  TodoBloc(this._repository) : super(TodoPageLoaded()) {
    on<LoadTodos>(_onLoadTodos);
    on<AddTodo>(_onAddTodo);
    on<UpdateTodo>(_onUpdateTodo);
    on<DeleteTodo>(_onDeleteTodo);
  }

  FutureOr<void> _onLoadTodos(
      LoadTodos event, Emitter<TodoState> emitter) async {
    emit(TodoPageLoading());
    try {
      final todos = await _repository.getTodos();
      emit(TodoPageLoaded(todos: todos));
    } catch (e) {
      emit(TodoError(e.toString()));
    }
  }

  Future<void> _onAddTodo(AddTodo event, Emitter<TodoState> emitter) async {
    final todo = await _repository.addTodo(event.todo);
    final state = this.state;
    if (state is TodoPageLoaded) {
      emit(TodoPageLoaded(todos: List.from(state.todos)..add(todo)));
    }
  }

  Future<void> _onUpdateTodo(
      UpdateTodo event, Emitter<TodoState> emitter) async {
    await _repository.updateTodo(event.todo);
    final state = this.state;
    if (state is TodoPageLoaded) {
      List<Todo> todos = state.todos.map((todo) {
        return todo.id == event.todo.id ? event.todo : todo;
      }).toList();
      emit(TodoPageLoaded(todos: List.from(todos)));
    }
  }

  Future<void> _onDeleteTodo(
      DeleteTodo event, Emitter<TodoState> emitter) async {
    await _repository.deleteTodo(event.todo.id!);
    final state = this.state;

    if (state is TodoPageLoaded) {
      List<Todo> todos = state.todos.where((task) {
        return task.id != event.todo.id;
      }).toList();
      emit(TodoPageLoaded(todos: todos));
    }
  }
}
