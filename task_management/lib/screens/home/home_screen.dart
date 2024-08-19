import 'package:animate_do/animate_do.dart'; // Import for animations
import 'package:flutter/material.dart'; // Import for Material Design widgets and theming
import 'package:hive/hive.dart'; // Import for Hive database
import 'package:lottie/lottie.dart'; // Import for Lottie animations
import 'package:task_management/extensions/space_exe.dart'; // Import for custom space extension
import 'package:task_management/main.dart'; // Import for the main application and global state
import 'package:task_management/models/task.dart'; // Import for the Task model
import 'package:task_management/screens/home/components/fab.dart'; // Import for the Floating Action Button component
import 'package:task_management/screens/home/components/home_app_bar.dart'; // Import for the AppBar component
import 'package:task_management/screens/home/components/slider_drawer.dart'; // Import for the slider drawer component
import 'package:task_management/screens/home/widgets/list_task_widget.dart'; // Import for the ListTaskWidget component
import 'package:task_management/utils/app_colors.dart'; // Import for custom app colors
import 'package:task_management/utils/app_string.dart'; // Import for application strings
import 'package:task_management/utils/constants.dart'; // Import for application constants
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart'; // Import for slider drawer package

// Stateful widget for the Home Screen
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() =>
      _HomeScreenState(); // Create state for HomeScreen
}

class _HomeScreenState extends State<HomeScreen> {
  // Global key to control the slider drawer state
  GlobalKey<SliderDrawerState> drawerKey = GlobalKey<SliderDrawerState>();

  // Returns the value of the circle indicator based on the number of tasks
  dynamic valueOfIndicator(List<Task> task) {
    if (task.isNotEmpty) {
      return task.length; // Return the number of tasks if the list is not empty
    } else {
      return 3; // Return a default value of 3 if the list is empty
    }
  }

  // Counts the number of completed tasks
  int checkDoneTasks(List<Task> tasks) {
    int i = 0;
    for (Task doneTask in tasks) {
      if (doneTask.isCompleted) {
        i++; // Increment count if the task is completed
      }
    }
    return i; // Return the count of completed tasks
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme =
        Theme.of(context).textTheme; // Get the current text theme
    final base = BaseWidget.of(context); // Get the base widget context
    return ValueListenableBuilder(
      valueListenable: base.dataStore
          .listenToTask(), // Listen to changes in the task database
      builder: (context, Box<Task> box, Widget? child) {
        var tasks = box.values.toList(); // Get list of tasks from the database
        // Sort tasks by creation date
        tasks.sort((a, b) => a.createdAtDate.compareTo(b.createdAtDate));
        return Scaffold(
          backgroundColor:
              Colors.white, // Set background color for the scaffold
          floatingActionButton:
              const FloatingAB(), // Add Floating Action Button
          body: SliderDrawer(
            key: drawerKey, // Set the key for the slider drawer
            isDraggable: false, // Prevent dragging of the slider drawer
            animationDuration:
                1000, // Set animation duration for the slider drawer
            slider: CustomDrawer(), // Set the custom drawer widget
            appBar: HomeAppBar(drawerKey: drawerKey), // Set the app bar widget
            child: _buildHomeBody(
                textTheme, base, tasks), // Build the home body content
          ),
        );
      },
    );
  }

  // Builds the main content of the Home Screen
  Widget _buildHomeBody(
      TextTheme textTheme, BaseWidget base, List<Task> tasks) {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 60), // Margin for the container
            height: 100,
            width: double.infinity,
            child: Row(
              mainAxisAlignment:
                  MainAxisAlignment.center, // Center content horizontally
              children: [
                SizedBox(
                  height: 35,
                  width: 35,
                  child: CircularProgressIndicator(
                    value: checkDoneTasks(tasks) /
                        valueOfIndicator(tasks), // Set the progress value
                    backgroundColor: Colors
                        .grey, // Background color of the progress indicator
                    valueColor: const AlwaysStoppedAnimation(
                        AppColors.primaryColor), // Color of the progress
                  ),
                ),
                // Space between the progress indicator and text
                25.w,
                Column(
                  mainAxisAlignment:
                      MainAxisAlignment.center, // Center content vertically
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppString.mainTitle, // Main title text
                      style: textTheme.displayLarge,
                    ),
                    // Space between the title and subtitle
                    3.h,
                    Text(
                      "${checkDoneTasks(tasks)} of ${tasks.length}", // Subtitle text showing task progress
                      style: textTheme.titleMedium,
                    ),
                  ],
                )
              ],
            ),
          ),

          // Divider
          const Padding(
            padding: EdgeInsets.only(top: 10),
            child: Divider(
              thickness: 2,
              indent: 100,
            ),
          ),

          // Display tasks or a message if no tasks are available
          SizedBox(
            width: double.infinity,
            height: 585,
            child: tasks.isNotEmpty
                ? ListView.builder(
                    physics:
                        const BouncingScrollPhysics(), // Add bounce effect to the list view
                    itemCount: tasks.length, // Number of tasks in the list
                    itemBuilder: (BuildContext context, int index) {
                      var task = tasks[index];

                      return Dismissible(
                        direction: DismissDirection
                            .horizontal, // Allow horizontal swipe to dismiss
                        background: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.delete_outline,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(AppString.deletedTask,
                                style: TextStyle(
                                  color: Colors.grey,
                                ))
                          ],
                        ),
                        onDismissed: (direction) {
                          base.dataStore.deleteTask(
                              task: task); // Delete the task from the database
                        },
                        key: Key(task.id), // Unique key for each task
                        child: ListTaskWidget(
                          task: tasks[
                              index], // Pass the task to the ListTaskWidget
                        ),
                      );
                    },
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Show animation and message if no tasks are available
                      FadeIn(
                        child: SizedBox(
                          width: 200,
                          height: 200,
                          child: Lottie.asset(
                            lottieURL, // URL or path to the Lottie animation
                            animate: tasks.isNotEmpty
                                ? false
                                : true, // Animate if no tasks
                          ),
                        ),
                      ),

                      // Bottom Texts
                      FadeInUp(
                        from: 30,
                        child: const Text(AppString
                            .doneAllTask), // Message indicating all tasks are done
                      ),
                    ],
                  ),
          )
        ],
      ),
    );
  }
}
