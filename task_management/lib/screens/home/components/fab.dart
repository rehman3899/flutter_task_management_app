import 'package:flutter/cupertino.dart';  // Import for Cupertino (iOS-style) widgets and navigation
import 'package:flutter/material.dart';  // Import for Material Design widgets and styling
import 'package:task_management/screens/tasks/task_screen.dart';  // Import for the TaskScreen where new tasks are added
import 'package:task_management/utils/app_colors.dart';  // Import for custom app colors

// A stateless widget that represents a floating action button (FAB) with an "add" icon
class FloatingAB extends StatelessWidget {
  const FloatingAB({super.key});  // Constructor with an optional key

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // GestureDetector allows for detecting taps and other gestures
      onTap: () {
        // When the FAB is tapped, navigate to the TaskScreen
        Navigator.of(context).push(
          CupertinoPageRoute(
            builder: (context) => TaskScreen(
              taskControllerForSubtitle: TextEditingController(),  // Controller for subtitle input
              taskControllerForTitle: TextEditingController(),  // Controller for title input
              task: null,  // No task is passed, indicating a new task is being created
            ),
          ),
        );
      },
      child: Material(
        // Material widget provides elevation and other material design properties
        borderRadius: BorderRadius.circular(15),  // Circular border radius for rounded corners
        elevation: 10,  // Elevation to create a shadow effect
        child: Container(
          width: 70,  // Fixed width of the FAB
          height: 70,  // Fixed height of the FAB
          decoration: BoxDecoration(
            color: AppColors.primaryColor,  // Background color from custom app colors
            borderRadius: BorderRadius.circular(15),  // Circular border radius to match the Material widget
          ),
          child: const Center(
            // Center widget aligns the child in the center of the container
            child: Icon(
              Icons.add,  // Add icon representing the action of creating a new task
              color: Colors.white,  // Icon color
            ),
          ),
        ),
      ),
    );
  }
}
