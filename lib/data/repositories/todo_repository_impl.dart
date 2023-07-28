// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc_sqlite/data/datasources/sqlite_database.dart';
import 'package:sqflite/sqflite.dart';

import 'package:flutter_bloc_sqlite/domain/models/todo.dart';
import 'package:flutter_bloc_sqlite/domain/repositories/todo_repository.dart';

class TodoRepositoryImpl extends TodoRepository {
  static const _table = 'todos';

  @override
  Future<Todo> addTodo(Todo todo) async {
    final db = await SqliteDatabase.db();
    todo.id = await db.insert(_table, todo.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return todo;
  }

  @override
  Future<void> deleteTodo(int id) async {
    final db = await SqliteDatabase.db();
    await db.delete(_table, where: 'id = ?', whereArgs: [id]);
  }

  @override
  Future<List<Todo>> getTodos() async {
    final db = await SqliteDatabase.db();
    final List<Map<String, dynamic>> maps = await db.query(_table);

    return List.generate(maps.length, (i) {
      return Todo(
        id: maps[i]['id'],
        title: maps[i]['title'],
        done: maps[i]['done'],
      );
    });
  }

  @override
  Future<int> updateTodo(Todo todo) async {
    final db = await SqliteDatabase.db();
    return await db
        .update(_table, todo.toJson(), where: 'id = ?', whereArgs: [todo.id]);
  }
}
