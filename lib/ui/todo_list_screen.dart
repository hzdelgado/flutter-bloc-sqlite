import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_sqlite/domain/bloc/todo_bloc.dart';
import 'package:flutter_bloc_sqlite/domain/bloc/todo_event.dart';
import 'package:flutter_bloc_sqlite/domain/bloc/todo_state.dart';
import 'package:flutter_bloc_sqlite/domain/models/todo.dart';
import 'package:flutter_bloc_sqlite/ui/widgets/todo_input_field.dart';
import 'package:flutter_bloc_sqlite/ui/widgets/todo_list_view.dart';
import 'package:fluttertoast/fluttertoast.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
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
                  msg: state.message!,
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
            }
            return  Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                  children: [
                    const Text(
                      "Todo",
                      style: TextStyle(
                          fontSize: 50,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold),
                    ),
                    TodoInputField(_onTodoItemAdded),
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height /2,
                      child: TodoListView(_todoList, _onTodoItemChanged),
                    )
                  ],
                ));
          },
          listener: (context, state) {
            //Here, you can permorn action like show toast, snackbar & dialog on the basis of state
          },
        ));
  }
}
