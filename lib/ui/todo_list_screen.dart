import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_sqlite/domain/bloc/todo_bloc.dart';
import 'package:flutter_bloc_sqlite/domain/bloc/todo_event.dart';
import 'package:flutter_bloc_sqlite/domain/bloc/todo_state.dart';
import 'package:flutter_bloc_sqlite/domain/models/todo.dart';
import 'package:flutter_bloc_sqlite/ui/common/dialog/android_dialog.dart';
import 'package:flutter_bloc_sqlite/ui/common/dialog/cupertino_dialog.dart';
import 'package:flutter_bloc_sqlite/ui/common/dialog/dialog.dart';
import 'package:flutter_bloc_sqlite/ui/widgets/todo_input_field.dart';
import 'package:flutter_bloc_sqlite/ui/widgets/todo_list_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  late TodoBloc _todoBloc;
  List<Todo> _todoList = [];
  int? selectedTodo;
  @override
  void initState() {
    _todoBloc = BlocProvider.of(context);
    _todoBloc.add(LoadTodos());

    super.initState();
  }

  void _onTodoItemAdded(Todo todo) {
    _todoBloc.add(AddTodo(todo: todo));
  }

  void _onTodoItemChanged(Todo todo, int index) {
    _todoBloc.add(UpdateTodo(todo: todo));
  }

  void _onTodoItemDeleted(
    Todo todo,
  ) {
    _todoBloc.add(DeleteTodo(todo: todo));
  }

  CustomDialog _getDialog() {
    if (Platform.isIOS) {
      return IosDialog();
    } else {
      return AndroidDialog();
    }
  }

  void _onEditActionConfirmed(
    String newValue,
  ) {
    if (selectedTodo == null) {
      Fluttertoast.showToast(
          msg: 'An error ocurred',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
    var found = _todoList.firstWhere((element) => element.id == selectedTodo);
    found = found.copyWith(title: newValue);

    _todoBloc.add(UpdateTodo(todo: found));
    Navigator.of(context).pop();
  }

  void _onEditActionPressed(int id) {
    selectedTodo = id;
    var dialog = _getDialog();

    dialog.show(context, _onEditActionConfirmed);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: RichText(
              textAlign: TextAlign.start,
              text: TextSpan(
                  text: "Todo ",
                  style: TextStyle(
                      fontSize: 40,
                      color: Colors.deepPurple.withOpacity(0.7),
                      fontWeight: FontWeight.w800),
                  children: [
                    TextSpan(
                      text: DateFormat.MMMEd().format(DateTime.now()),
                      style: TextStyle(
                          fontSize: 24,
                          color: Colors.deepPurple.withOpacity(0.3)),
                    ),
                  ])),
          centerTitle: false,
        ),
        body: BlocConsumer<TodoBloc, TodoState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is TodoPageLoading) {
              return const CircularProgressIndicator();
            } else if (state is TodoPageLoaded) {
              if (state.todos.isNotEmpty == true) {
                _todoList = state.todos;
              }
            } else if (state is TodoError) {
              Fluttertoast.showToast(
                  msg: state.message ?? 'error',
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TodoInputField(_onTodoItemAdded),
                SizedBox(
                  width: MediaQuery.sizeOf(context).width,
                  height: MediaQuery.sizeOf(context).height / 2,
                  child: TodoListView(_todoList, _onTodoItemChanged,
                      _onTodoItemDeleted, _onEditActionPressed),
                )
              ],
            );
          },
        ));
  }
}
