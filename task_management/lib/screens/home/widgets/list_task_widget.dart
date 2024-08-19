import 'package:flutter/cupertino.dart';  // Import for Cupertino (iOS-style) widgets and navigation
import 'package:flutter/material.dart';  // Import for Material Design widgets and styling
import 'package:intl/intl.dart';  // Import for date formatting utilities
import 'package:task_management/models/task.dart';  // Import for the Task model
import 'package:task_management/screens/tasks/task_screen.dart';  // Import for the TaskScreen widget
import 'package:task_management/utils/app_colors.dart';  // Import for custom app colors

// Stateful widget representing a task item in a list
class ListTaskWidget extends StatefulWidget {
  const ListTaskWidget({
    super.key,
    required this.task,  // Task to be displayed in this widget
  });

  final Task task;  // Task model instance containing task data

  @override
  State<ListTaskWidget> createState() => _ListTaskWidgetState();  // Create state for this widget
}

// State class for ListTaskWidget, managing task details and interactions
class _ListTaskWidgetState extends State<ListTaskWidget> {
  // Controllers for managing task title and subtitle input
  TextEditingController textEditingControllerTitle = TextEditingController();
  TextEditingController textEditingControllerSubTitle = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialize controllers with task data
    textEditingControllerTitle.text = widget.task.title;
    textEditingControllerSubTitle.text = widget.task.subTitle;
  }

  @override
  void dispose() {
    // Dispose of controllers when no longer needed
    textEditingControllerTitle.dispose();
    textEditingControllerSubTitle.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // GestureDetector allows for detecting taps
      onTap: () {
        // Navigate to Task Detail screen with the current task
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => TaskScreen(
              taskControllerForTitle: textEditingControllerTitle,
              taskControllerForSubtitle: textEditingControllerSubTitle,
              task: widget.task,
            ),
          ),
        );
      },
      child: AnimatedContainer(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),  // Margin around the container
        duration: const Duration(milliseconds: 600),  // Duration for container animations
        decoration: BoxDecoration(
          // Decoration for the container
          color: widget.task.isCompleted
              ? const Color.fromARGB(154, 119, 144, 229)  // Background color if task is completed
              : Colors.white,  // Background color if task is not completed
          borderRadius: BorderRadius.circular(8),  // Rounded corners
          boxShadow: [
            // Shadow for the container
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              offset: const Offset(0, 4),
              blurRadius: 10,
            ),
          ],
        ),
        child: ListTile(
          leading: GestureDetector(
            // GestureDetector for handling taps on the leading icon
            onTap: () {
              // Toggle the completion status of the task
              setState(() {
                widget.task.isCompleted = !widget.task.isCompleted;
                widget.task.save();  // Save the updated task state
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 600),  // Duration for icon animations
              decoration: BoxDecoration(
                // Decoration for the icon container
                color: widget.task.isCompleted
                    ? AppColors.primaryColor  // Icon color if task is completed
                    : Colors.white,  // Icon color if task is not completed
                shape: BoxShape.circle,  // Circular shape for the icon
                border: Border.all(
                  color: Colors.grey,
                  width: 0.8,
                ),
              ),
              child: const Icon(
                Icons.check,  // Check icon indicating task completion
                color: Colors.white,  // Icon color
              ),
            ),
          ),
          title: Padding(
            // Padding around the title text
            padding: const EdgeInsets.only(bottom: 5, top: 3),
            child: Text(
              textEditingControllerTitle.text,  // Display task title
              style: TextStyle(
                color: widget.task.isCompleted
                    ? AppColors.primaryColor  // Title color if task is completed
                    : Colors.black,  // Title color if task is not completed
                fontWeight: FontWeight.w500,  // Font weight for the title
                decoration: widget.task.isCompleted
                    ? TextDecoration.lineThrough  // Strike-through if task is completed
                    : null,  // No decoration if task is not completed
              ),
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Subtitle text showing task details
              Text(
                textEditingControllerSubTitle.text,  // Display task subtitle
                style: TextStyle(
                  color: widget.task.isCompleted
                      ? AppColors.primaryColor  // Subtitle color if task is completed
                      : Colors.black,  // Subtitle color if task is not completed
                  fontWeight: FontWeight.w300,  // Font weight for the subtitle
                  decoration: widget.task.isCompleted
                      ? TextDecoration.lineThrough  // Strike-through if task is completed
                      : null,  // No decoration if task is not completed
                ),
              ),
              // Task creation date and time
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(top: 3, bottom: 3),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        DateFormat('hh:mm a').format(widget.task.createdAtTime),  // Format and display task creation time
                        style: TextStyle(
                          color: widget.task.isCompleted
                              ? Colors.white  // Time color if task is completed
                              : Colors.grey,  // Time color if task is not completed
                          fontSize: 14,  // Font size for the time
                        ),
                      ),
                      Text(
                        DateFormat.yMMMEd().format(widget.task.createdAtDate),  // Format and display task creation date
                        style: TextStyle(
                          color: widget.task.isCompleted
                              ? Colors.white  // Date color if task is completed
                              : Colors.grey,  // Date color if task is not completed
                          fontSize: 12,  // Font size for the date
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
