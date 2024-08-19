import 'package:flutter/cupertino.dart';  // Import for Cupertino (iOS-style) widgets and icons
import 'package:flutter/material.dart';  // Import for Material Design widgets and icons
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';  // Import for the slider drawer package
import 'package:task_management/main.dart';  // Import for the main app file (assumed to contain BaseWidget and other app components)
import 'package:task_management/utils/constants.dart';  // Import for constants and utility functions (assumed)

// Stateful widget representing the app bar with a drawer toggle button and a delete button
class HomeAppBar extends StatefulWidget {
  const HomeAppBar({super.key, required this.drawerKey});  // Constructor with a required drawerKey parameter

  final GlobalKey<SliderDrawerState> drawerKey;  // Key to control the slider drawer

  @override
  State<HomeAppBar> createState() => _HomeAppBarState();  // Create state for the app bar
}

// State class for HomeAppBar, managing drawer toggle animations and actions
class _HomeAppBarState extends State<HomeAppBar> with SingleTickerProviderStateMixin {
  late AnimationController animationController;  // Controller for the drawer toggle animation
  bool isDrawerOpen = false;  // State to track if the drawer is currently open

  @override
  void initState() {
    super.initState();
    // Initialize the animation controller
    animationController = AnimationController(
      vsync: this,  // The TickerProvider for animation
      duration: const Duration(seconds: 1),  // Duration of the animation
    );
  }

  @override
  void dispose() {
    // Dispose of the animation controller when no longer needed
    animationController.dispose();
    super.dispose();
  }

  // Toggle the drawer state and animate the icon
  void onDrawerToggle() {
    setState(() {
      isDrawerOpen = !isDrawerOpen;  // Toggle the drawer state
      if (isDrawerOpen) {
        animationController.forward();  // Play the forward animation if the drawer is opening
        widget.drawerKey.currentState!.openSlider();  // Open the drawer
      } else {
        animationController.reverse();  // Play the reverse animation if the drawer is closing
        widget.drawerKey.currentState!.closeSlider();  // Close the drawer
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Retrieve the data store from the BaseWidget
    var base = BaseWidget.of(context).dataStore.box;

    return SizedBox(
      width: double.infinity,  // Full width
      height: 120,  // Fixed height for the app bar
      child: Padding(
        padding: const EdgeInsets.only(top: 20),  // Top padding for positioning
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,  // Space out children evenly
          children: [
            // Button to toggle the drawer
            Padding(
              padding: const EdgeInsets.only(left: 20),  // Left padding for positioning
              child: IconButton(
                onPressed: onDrawerToggle,  // Trigger drawer toggle on press
                icon: AnimatedIcon(
                  icon: AnimatedIcons.menu_close,  // Animated icon for menu to close transition
                  progress: animationController,  // Animation controller for the icon
                  size: 40,  // Icon size
                ),
              ),
            ),
            // Button to delete all tasks
            Padding(
              padding: const EdgeInsets.only(right: 20),  // Right padding for positioning
              child: IconButton(
                onPressed: () {
                  // Perform action based on the presence of tasks
                  base.isEmpty
                      ? noTaskWarning(context)  // Show warning if no tasks are present
                      : deleteAllTask(context);  // Delete all tasks if present
                },
                icon: const Icon(
                  CupertinoIcons.trash_fill,  // Trash icon for delete action
                  size: 40,  // Icon size
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
