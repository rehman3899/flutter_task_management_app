import 'package:flutter/material.dart';  // Import for Material Design widgets and theming
import 'package:flutter_cupertino_date_picker_fork/flutter_cupertino_date_picker_fork.dart';  // Import for Cupertino date picker
import 'package:intl/intl.dart';  // Import for date formatting
import 'package:task_management/main.dart';  // Import for the main application and global state
import 'package:task_management/models/task.dart';  // Import for the Task model
import 'package:task_management/screens/tasks/components/add_task_text_field.dart';  // Import for the text field component
import 'package:task_management/screens/tasks/components/date_time_selection.dart';  // Import for date and time selection components
import 'package:task_management/screens/tasks/widgets/task_screen_app_bar.dart';  // Import for the app bar component
import 'package:task_management/utils/app_colors.dart';  // Import for custom app colors
import 'package:task_management/utils/app_string.dart';  // Import for application strings
import 'package:task_management/utils/constants.dart';  // Import for application constants


// ignore: must_be_immutable
class TaskScreen extends StatefulWidget {
  TaskScreen({
    super.key,
    required this.taskControllerForTitle,  // Controller for the task title input field
    required this.taskControllerForSubtitle,  // Controller for the task subtitle input field
    required this.task,  // The task object to be edited or null for a new task
  });

  TextEditingController? taskControllerForTitle;  // Controller for task title input
  TextEditingController? taskControllerForSubtitle;  // Controller for task subtitle input
  final Task? task;  // The task object to be edited or created

  @override
  State<TaskScreen> createState() => _TaskScreenState();  // Create state for TaskScreen
}

class _TaskScreenState extends State<TaskScreen> {
  var title;  // Variable to store task title
  var subtitle;  // Variable to store task subtitle
  DateTime? time;  // Variable to store selected time
  DateTime? date;  // Variable to store selected date

  /// Format and return the selected time as a string
  String showTime(DateTime? time) {
    if (widget.task?.createdAtTime == null) {
      if (time == null) {
        return DateFormat('hh:mm a').format(DateTime.now()).toString();  // Return current time if no time is selected
      } else {
        return DateFormat('hh:mm a').format(time).toString();  // Format and return selected time
      }
    } else {
      return DateFormat('hh:mm a').format(widget.task!.createdAtTime).toString();  // Return task's created time if available
    }
  }

  /// Return the selected time as a DateTime object
  DateTime showTimeAsDateTime(DateTime? time) {
    if (widget.task?.createdAtTime == null) {
      if (time == null) {
        return DateTime.now();  // Return current time if no time is selected
      } else {
        return time;  // Return selected time
      }
    } else {
      return widget.task!.createdAtTime;  // Return task's created time if available
    }
  }

  /// Format and return the selected date as a string
  String showDate(DateTime? date) {
    if (widget.task?.createdAtDate == null) {
      if (date == null) {
        return DateFormat.yMMMEd().format(DateTime.now()).toString();  // Return current date if no date is selected
      } else {
        return DateFormat.yMMMEd().format(date).toString();  // Format and return selected date
      }
    } else {
      return DateFormat.yMMMEd().format(widget.task!.createdAtDate).toString();  // Return task's created date if available
    }
  }

  // Return the selected date as a DateTime object
  DateTime showDateAsDateTime(DateTime? date) {
    if (widget.task?.createdAtDate == null) {
      if (date == null) {
        return DateTime.now();  // Return current date if no date is selected
      } else {
        return date;  // Return selected date
      }
    } else {
      return widget.task!.createdAtDate;  // Return task's created date if available
    }
  }

  /// Check if the task already exists based on the title and subtitle controllers
  bool isTaskAlreadyExistBool() {
    if (widget.taskControllerForTitle?.text == null &&
        widget.taskControllerForSubtitle?.text == null) {
      return false;  // Return false if both title and subtitle are empty
    } else {
      return true;  // Return true if either title or subtitle is not empty
    }
  }

  /// Handle task update or creation based on whether the task already exists
  dynamic isTaskAlreadyExistUpdateTask() {
    if (widget.taskControllerForTitle?.text != null &&
        widget.taskControllerForSubtitle?.text != null) {
      try {
        widget.taskControllerForTitle?.text = title;  // Update title in the controller
        widget.taskControllerForSubtitle?.text = subtitle;  // Update subtitle in the controller

        // Update task details if task exists
        widget.task?.save();
        Navigator.of(context).pop();  // Close the screen
      } catch (error) {
        emptyWarning(context);  // Show warning if an error occurs
      }
    } else {
      if (title != null && subtitle != null) {
        // Create and add a new task if the title and subtitle are not null
        var task = Task.create(
          title: title,
          createdAtTime: time,
          createdAtDate: date,
          subTitle: subtitle,
        );
        BaseWidget.of(context).dataStore.addTask(task: task);  // Add task to the database
        Navigator.of(context).pop();  // Close the screen
      } else {
        updateTaskWarning(context);  // Show warning if title or subtitle is null
      }
    }
  }

  /// Delete the current task
  dynamic deleteTask() {
    widget.task?.delete();  // Delete the task from the database
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;  // Get the current text theme
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),  // Dismiss keyboard on tap
      child: Scaffold(
        backgroundColor: Colors.white,  // Set background color for the scaffold
        appBar: const TaskScreenAppBar(),  // Set the app bar
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Center(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),  // Add bounce effect to the scroll view
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  /// Display text for adding or updating a task
                  _buildTopSideText(textTheme),

                  /// Display text fields for task title and subtitle, and widgets for time and date selection
                  _addTaskScreenActivity(textTheme, context),

                  /// Display buttons for adding/updating and deleting tasks
                  _buildBottomButtons(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Build and return the bottom buttons (add/update and delete)
  Padding _buildBottomButtons(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: isTaskAlreadyExistBool()
            ? MainAxisAlignment.center
            : MainAxisAlignment.spaceEvenly,
        children: [
          isTaskAlreadyExistBool()
              ? Container()  // Empty container if task already exists
              : Container(
                  width: 150,
                  height: 55,
                  decoration: BoxDecoration(
                      border:
                          Border.all(color: AppColors.primaryColor, width: 2),
                      borderRadius: BorderRadius.circular(15)),
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    minWidth: 150,
                    height: 55,
                    onPressed: () {
                      deleteTask();  // Call delete task method
                      Navigator.pop(context);  // Close the screen
                    },
                    color: Colors.white,
                    child: const Row(
                      children: [
                        Icon(
                          Icons.close,
                          color: AppColors.primaryColor,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          AppString.deleteTask,
                          style: TextStyle(
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

          /// Button to add or update a task
          MaterialButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            minWidth: 150,
            height: 55,
            onPressed: () {
              isTaskAlreadyExistUpdateTask();  // Call method to add or update task
            },
            color: AppColors.primaryColor,
            child: Text(
              isTaskAlreadyExistBool()
                  ? AppString.addTaskString  // Show "Add Task" if task does not exist
                  : AppString.updateTaskString,  // Show "Update Task" if task exists
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Build and return the section for adding task details (title, subtitle, time, date)
  SizedBox _addTaskScreenActivity(TextTheme textTheme, BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 510,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title text field
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Text(
              AppString.titleOfTextField,
              style: textTheme.headlineMedium,
            ),
          ),

          // Task Title text field
          AddTaskTextField(
            controller: widget.taskControllerForTitle!,
            onFieldSubmitted: (value) {
              title = value;  // Update title variable on field submission
              FocusManager.instance.primaryFocus?.unfocus();  // Dismiss keyboard
            },
            onChanged: (value) {
              title = value;  // Update title variable on text change
            },
          ),

          // Task Subtitle text field
          AddTaskTextField(
            controller: widget.taskControllerForSubtitle!,
            isForDescription: true,
            onFieldSubmitted: (value) {
              subtitle = value;  // Update subtitle variable on field submission
            },
            onChanged: (value) {
              subtitle = value;  // Update subtitle variable on text change
            },
          ),

          // Time selection widget
          DateTimeSelectionWidget(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (_) => SizedBox(
                  height: 280,
                  child: TimePickerWidget(
                    initDateTime: showDateAsDateTime(time),  // Initialize with selected time or current time
                    onChange: (_, __) {},
                    dateFormat: 'HH:mm',
                    onConfirm: (dateTime, _) {
                      setState(() {
                        if (widget.task?.createdAtTime == null) {
                          time = dateTime;  // Update time variable
                        } else {
                          time = widget.task!.createdAtTime;  // Use existing task time
                        }
                      });
                    },
                  ),
                ),
              );
            },
            title: AppString.timeString,
            time: showTime(time),  // Display formatted time
          ),

          // Date selection widget
          DateTimeSelectionWidget(
            onTap: () {
              DatePicker.showDatePicker(
                initialDateTime: showDateAsDateTime(date),  // Initialize with selected date or current date
                context,
                maxDateTime: DateTime(2030, 4, 5),
                minDateTime: DateTime.now(),
                onConfirm: (dateTime, _) {
                  setState(() {
                    if (widget.task?.createdAtDate == null) {
                      date = dateTime;  // Update date variable
                    } else {
                      date = widget.task!.createdAtDate;  // Use existing task date
                    }
                  });
                },
              );
            },
            title: AppString.dateString,
            isTime: true,
            time: showDate(date),  // Display formatted date
          )
        ],
      ),
    );
  }

  /// Build and return the top side text widget showing add/update task information
  Widget _buildTopSideText(TextTheme textTheme) {
    return SizedBox(
      width: double.infinity,
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            width: 70,
            child: Divider(
              thickness: 2,
            ),
          ),
          RichText(
            text: TextSpan(
              text: isTaskAlreadyExistBool()
                  ? AppString.addNewTask  // Show "Add New Task" if task does not exist
                  : AppString.updateCurrentTask,  // Show "Update Current Task" if task exists
              style: textTheme.titleLarge,
              children: const [
                TextSpan(
                  text: AppString.taskString,
                  style: TextStyle(fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 70,
            child: Divider(
              thickness: 2,
            ),
          ),
        ],
      ),
    );
  }
}
