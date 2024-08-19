import 'package:flutter/material.dart';  // Import Flutter Material widgets
import 'package:task_management/utils/app_string.dart';  // Import application-specific string constants

/// A custom text field for adding task titles or descriptions.
class AddTaskTextField extends StatelessWidget {
  const AddTaskTextField({
    super.key,
    required this.controller,  // Controller to manage the text field's input
    this.isForDescription = false,  // Flag to determine if the text field is for a description
    required this.onFieldSubmitted,  // Callback function when the field is submitted
    required this.onChanged,  // Callback function when the text changes
  });

  final TextEditingController controller;  // Controller to interact with the text field
  final Function(String) onFieldSubmitted;  // Function to be called on field submission
  final Function(String) onChanged;  // Function to be called when text changes
  final bool isForDescription;  // Flag to distinguish between title and description

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,  // Make the container take the full width of its parent
      margin: const EdgeInsets.symmetric(horizontal: 16),  // Horizontal margin for spacing
      child: ListTile(
        title: TextFormField(
          controller: controller,  // Assign the controller to the text field
          maxLines: !isForDescription ? 5 : null,  // Allow multiple lines if not a description
          cursorHeight: !isForDescription ? 50 : null,  // Increase cursor height for titles
          cursorWidth: 2,  // Set the width of the cursor
          style: const TextStyle(color: Colors.black),  // Text color in the text field
          decoration: InputDecoration(
            border: isForDescription ? InputBorder.none : null,  // No border for descriptions
            counter: Container(),  // Hide character counter
            hintText: isForDescription ? AppString.addNote : null,  // Hint text for description field
            prefixIcon: isForDescription
                ? const Icon(
                    Icons.bookmark_border,  // Icon for description field
                    color: Colors.grey,
                  )
                : null,
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey.shade300,  // Color of the border when enabled
              ),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey.shade300,  // Color of the border when focused
              ),
            ),
          ),
          onFieldSubmitted: onFieldSubmitted,  // Call the function when the field is submitted
          onChanged: onChanged,  // Call the function when text changes
        ),
      ),
    );
  }
}
