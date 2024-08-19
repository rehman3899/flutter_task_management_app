import 'package:flutter/foundation.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:task_management/models/task.dart';

// This class is a data store that interacts with a Hive database to manage tasks.
class HiveDataStore {

  // Name of the Hive box where tasks are stored.
  static const boxName = 'taskBox';

  // Reference to the Hive box that stores Task objects.
  final Box<Task> box = Hive.box<Task>(boxName);

  // Adds a new task to the Hive box.
  Future<void> addTask({required Task task}) async {
    // Stores the task using its id as the key.
    await box.put(task.id, task);
  }

  // Retrieves a task from the Hive box using its id.
  Future<Task?> getTask({required String id}) async {
    return box.get(id);
  }

  // Updates an existing task in the Hive box.
  Future<void> updateTask({required Task task}) async {
    // Calls the save method on the task object to update it in the box.
    await task.save();
  }

  // Deletes a task from the Hive box.
  Future<void> deleteTask({required Task task}) async {
    // Calls the delete method on the task object to remove it from the box.
    await task.delete();
  }

  // Returns a ValueListenable that allows listening to changes in the Hive box.
  ValueListenable<Box<Task>> listenToTask() => box.listenable();
}
