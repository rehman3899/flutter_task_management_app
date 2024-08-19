import 'package:hive/hive.dart'; // Import Hive for local storage management
import 'package:uuid/uuid.dart'; // Import UUID for generating unique IDs

part 'task.g.dart'; // Generated file part for Hive type adapter

// Annotate the class as a Hive type with a typeId of 0
@HiveType(typeId: 0)
class Task extends HiveObject {
  // Constructor for the Task class with required fields
  Task({
    required this.id, // Unique ID for the task
    required this.title, // Title of the task
    required this.subTitle, // Subtitle or description of the task
    required this.createdAtTime, // Time when the task was created
    required this.createdAtDate, // Date when the task was created
    required this.isCompleted, // Status of the task (completed or not)
  });

  // Annotate id as a Hive field with index 0
  @HiveField(0)
  final String id;

  // Annotate title as a Hive field with index 1
  @HiveField(1)
  String title;

  // Annotate subTitle as a Hive field with index 2
  @HiveField(2)
  String subTitle;

  // Annotate createdAtTime as a Hive field with index 3
  @HiveField(3)
  DateTime createdAtTime;

  // Annotate createdAtDate as a Hive field with index 4
  @HiveField(4)
  DateTime createdAtDate;

  // Annotate isCompleted as a Hive field with index 5
  @HiveField(5)
  bool isCompleted;

  // Factory constructor for creating a new Task with optional parameters
  // Generate a unique ID using UUID
  // Assign title or default to empty string
  // Assign subtitle or default to empty string
  // Assign creation time or default to now
  // Assign creation date or default to now
  // New tasks are not completed by default
  factory Task.create({
    required String? title,
    required String? subTitle,
    DateTime? createdAtTime,
    DateTime? createdAtDate,
  }) =>
      Task(
        id: const Uuid().v1(),
        title: title ?? '',
        subTitle: subTitle ?? '',
        createdAtTime: createdAtTime ?? DateTime.now(),
        createdAtDate: createdAtDate ?? DateTime.now(),
        isCompleted: false,
      );
}
