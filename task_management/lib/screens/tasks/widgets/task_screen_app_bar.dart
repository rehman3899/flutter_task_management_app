import 'package:flutter/material.dart';  // Import Flutter Material widgets

/// A custom app bar for the task screen.
/// Implements PreferredSizeWidget to specify a custom size for the app bar.
class TaskScreenAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TaskScreenAppBar({super.key});  // Constructor with optional key parameter

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,  // Make the app bar take the full width of its parent
      height: 150,  // Set the height of the app bar
      child: Padding(
        padding: const EdgeInsets.only(left: 20),  // Add padding to the left
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20),  // Add padding to the top
              child: GestureDetector(
                onTap: () {
                  // Navigate back to the previous screen when the icon is tapped
                  Navigator.of(context).pop();
                },
                child: const Icon(
                  Icons.arrow_back_ios_new_rounded,  // Back arrow icon
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(150);  // Specify the preferred size of the app bar
}
