import 'package:hive/hive.dart';
import 'package:todo/features/todo/domain/entities/todo.dart';

part 'todo_model.g.dart';

@HiveType(typeId: 0) // Type ID for this model
class TodoModel {
  @HiveField(0)
  String title;

  @HiveField(1)
  bool isCompleted;

  TodoModel({
    required this.title,
    this.isCompleted = false,
  });

  // Convert Data Model to Domain Model
  static Todo toDomain(TodoModel entity) {
    return Todo(
      title: entity.title,
      isCompleted: entity.isCompleted,
    );
  }

  // Convert Domain Model to Data Model
  static TodoModel toData(Todo model) {
    return TodoModel(
      title: model.title,
      isCompleted: model.isCompleted,
    );
  }
}
