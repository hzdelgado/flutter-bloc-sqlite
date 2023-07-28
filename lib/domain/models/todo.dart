
import 'package:freezed_annotation/freezed_annotation.dart';

part 'todo.freezed.dart';
part 'todo.g.dart';

@unfreezed
class Todo with _$Todo {
  factory Todo({
    int? id,
    required String title,
    @Default(0) int done,
  }) = _Todo;

  factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);
}
