import 'package:flutter/material.dart';  // Import for Material Design widgets and theming

/// Widget for selecting and displaying time or date
class DateTimeSelectionWidget extends StatelessWidget {
  const DateTimeSelectionWidget({
    super.key,
    required this.onTap,  // Callback function to be executed when the widget is tapped
    required this.title,  // Title to display on the widget
    required this.time,  // Time or date to display on the widget
    this.isTime = false,  // Boolean flag to determine if the widget displays time (true) or date (false)
  });

  final VoidCallback onTap;  // Function to be called on widget tap
  final String title;  // Title of the widget
  final String time;  // Time or date to display
  final bool isTime;  // Flag to indicate if the widget is for time

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;  // Get the current text theme
    return GestureDetector(
      onTap: onTap,  // Call the provided onTap function when the widget is tapped
      child: Container(
        width: double.infinity,  // Make the container take up the full width
        height: 55,  // Set the height of the container
        margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),  // Set margins for the container
        decoration: BoxDecoration(
          color: Colors.white,  // Background color of the container
          border: Border.all(
            color: Colors.grey.shade300,  // Border color
          ),
          borderRadius: BorderRadius.circular(15),  // Round the corners of the container
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,  // Align children with space between them
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),  // Add padding on the left
              child: Text(
                title,  // Display the title text
                style: textTheme.headlineSmall,  // Use the small headline style from the text theme
              ),
            ),
            Container(
              margin: const EdgeInsets.only(right: 10),  // Add margin on the right
              width: isTime ? 150 : 80,  // Set width based on whether it displays time or date
              height: 35,  // Set the height of the inner container
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),  // Round the corners of the inner container
                  color: Colors.grey.shade100),  // Background color of the inner container
              child: Center(
                child: Text(
                  time,  // Display the time or date
                  style: textTheme.titleSmall,  // Use the small title style from the text theme
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
