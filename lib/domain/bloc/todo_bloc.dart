import 'package:flutter_bloc_sqlite/domain/bloc/todo_event.dart';
import 'package:flutter_bloc_sqlite/domain/bloc/todo_state.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc_sqlite/domain/repositories/todo_repository.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoRepository _repository;
  TodoBloc(this._repository): super(TodoInitial()) {
    on<LoadTodos>(_onLoadTodos);
    on<AddTodo>(_onAddTodo);
    on<UpdateTodo>(_onUpdateTodo);
    on<DeleteTodo>(_onDeleteTodo);
  }

  Future<void> _onLoadTodos(LoadTodos event, Emitter<TodoState> emitter) async {

  }

  Future<void> _onAddTodo(AddTodo event, Emitter<TodoState> emitter) async {

  }

  Future<void> _onUpdateTodo(UpdateTodo event, Emitter<TodoState> emitter) async {

  }

  Future<void> _onDeleteTodo(DeleteTodo event, Emitter<TodoState> emitter) async {

  }
}