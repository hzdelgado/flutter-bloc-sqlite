import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_sqlite/domain/bloc/todo_bloc.dart';
import 'package:flutter_bloc_sqlite/domain/bloc/todo_event.dart';
import 'package:flutter_bloc_sqlite/domain/bloc/todo_state.dart';
import 'package:flutter_bloc_sqlite/domain/models/todo.dart';
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

   void _onTodoItemDeleted(Todo todo,) {
    _todoBloc.add(DeleteTodo(todo: todo));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(title:  Text(
                      DateFormat.MMMEd().format(DateTime.now()),
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                          fontSize: 50,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold),
                    ), centerTitle: false,),
        body: BlocConsumer<TodoBloc, TodoState>(
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
            return  Column(
                  children: [

                    TodoInputField(_onTodoItemAdded),
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width,
                      height: MediaQuery.sizeOf(context).height /2,
                      child: TodoListView(_todoList, _onTodoItemChanged, _onTodoItemDeleted),
                    )
                  ],
                );
          },
          listener: (context, state) {
            //Here, you can permorn action like show toast, snackbar & dialog on the basis of state
          },
        ));
  }
}
