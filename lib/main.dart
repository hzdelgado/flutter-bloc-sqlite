import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_sqlite/data/datasources/sqlite_database.dart';
import 'package:flutter_bloc_sqlite/data/repositories/todo_repository_impl.dart';
import 'package:flutter_bloc_sqlite/domain/bloc/todo_bloc.dart';
import 'package:flutter_bloc_sqlite/domain/bloc/todo_event.dart';
import 'package:flutter_bloc_sqlite/ui/todo_list_screen.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sqfliteFfiInit();
  databaseFactoryOrNull = databaseFactoryFfi;
  await SqliteDatabase.db();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: RepositoryProvider(
        create: (context) => TodoRepositoryImpl(),
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
                create: (context) => TodoBloc(
                      RepositoryProvider.of<TodoRepositoryImpl>(context),
                    )..add(LoadTodos()))
          ],
          child: const TodoListScreen(),
        ),
      ),
    );
  }
}

