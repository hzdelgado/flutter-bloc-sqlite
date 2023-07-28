import 'package:flutter_bloc_sqlite/data/datasources/sqlite_database.dart';
import 'package:flutter_bloc_sqlite/data/repositories/todo_repository_impl.dart';
import 'package:flutter_bloc_sqlite/domain/models/todo.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../../fixture/dummy_data.dart';
import 'todo_repository_test.mocks.dart';

@GenerateNiceMocks([MockSpec<TodoRepositoryImpl>()])
void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  late TodoRepositoryImpl repository;
  late Database database;

  setUpAll(
    () async {
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;
      database = await SqliteDatabase.db();
      repository = TodoRepositoryImpl();
    },
  );

  tearDownAll(() => SqliteDatabase.deleteDb());

  test('add todo into todos table', () async {
    final todo = await repository.addTodo(generateDummyTodo());
    final todos = await database.query('todos');
    expect(todos.length, 1);
    expect(todos.first['id'], todo.id);
  });

  test('update record in todo table', () async {
    final todo = await repository.addTodo(generateDummyTodo());
    todo.done = 1;
    final count = await repository.updateTodo(todo);
    expect(count, 1);
    expect(todo.done, 1);
  });

  test('delete todo from todos table', () async {
    final todo = await repository.addTodo(generateDummyTodo());
    await repository.deleteTodo(todo.id!);
    final todos = await database.query('todos', where: 'id = ?', whereArgs: [todo.id]);
    expect(todos.length, 0);
  });

  test('get todos from todos table', () async {
    final todos = await repository.getTodos();
    expect(todos.isNotEmpty, true);
    expect(todos.first, isInstanceOf<Todo>());
  });
}
