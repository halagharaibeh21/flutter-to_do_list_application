import 'package:hive_flutter/hive_flutter.dart';

@HiveType(typeId: 0)
class Todo extends HiveObject {
  @HiveField(0)
  late String title;

  @HiveField(1)
  late String description;

  @HiveField(2)
  late bool isCompleted;

  @HiveField(3)
  late DateTime dateTime;

  @HiveField(4)
  late bool isInProgress;

  Todo({
    required this.title,
    required this.description,
    required this.dateTime,
    this.isCompleted = false,
    this.isInProgress = false,
  });
}

class TodoAdapter extends TypeAdapter<Todo> {
  @override
  final int typeId = 0;

  @override
  Todo read(BinaryReader reader) {
    return Todo(
      title: reader.readString(),
      description: reader.readString(),
      dateTime: DateTime.parse(reader.readString()),
      isCompleted: reader.readBool(),
      isInProgress: reader.readBool(),
    );
  }

  @override
  void write(BinaryWriter writer, Todo obj) {
    writer.writeString(obj.title);
    writer.writeString(obj.description);
    writer.writeString(obj.dateTime.toIso8601String());
    writer.writeBool(obj.isCompleted);
    writer.writeBool(obj.isInProgress);
  }
}
