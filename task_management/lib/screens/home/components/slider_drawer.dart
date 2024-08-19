import 'dart:developer';  // Import for logging in the console

import 'package:flutter/cupertino.dart';  // Import for Cupertino widgets and icons
import 'package:flutter/material.dart';  // Import for Material design widgets and icons
import 'package:task_management/extensions/space_exe.dart';  // Custom extension for spacing (assumed)
import 'package:task_management/utils/app_colors.dart';  // Custom utility for app colors

// CustomDrawer is a stateless widget that represents a drawer with a profile section and menu items.
class CustomDrawer extends StatelessWidget {
  CustomDrawer({super.key});

  // List of icons used in the ListTile items in the drawer
  final List<IconData> icons = [
    CupertinoIcons.home,               // Home icon
    CupertinoIcons.person_fill,         // Profile icon
    CupertinoIcons.settings,            // Settings icon
    CupertinoIcons.info_circle_fill,    // Info/Details icon
  ];

  // Corresponding text labels for each ListTile item in the drawer
  final List<String> text = [
    'Home',       // Label for Home
    'Profile',    // Label for Profile
    'Setting',    // Label for Settings
    'Details',    // Label for Details
  ];

  @override
  Widget build(BuildContext context) {
    // Get the current theme's text styles
    var textTheme = Theme.of(context).textTheme;
    
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 90),  // Vertical padding for the container
      decoration: const BoxDecoration(
        // Apply a gradient background to the drawer
        gradient: LinearGradient(
          colors: AppColors.primaryGradientColor,  // Use custom colors from AppColors utility
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        children: [
          const CircleAvatar(
            radius: 50,  // Size of the avatar
            // Profile image from a network source
            backgroundImage: NetworkImage(
                'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a0/Andrzej_Person_Kancelaria_Senatu.jpg/1200px-Andrzej_Person_Kancelaria_Senatu.jpg'),
          ),
          8.h,  // Spacing using custom extension
          Text('Abdul Rehman', style: textTheme.displayMedium),  // Display name with text style
          Text('Flutter Developer', style: textTheme.displaySmall),  // Display role with text style
          Container(
            margin: const EdgeInsets.symmetric(
              vertical: 30,  // Vertical margin
              horizontal: 10,  // Horizontal margin
            ),
            width: double.infinity,  // Full width of the container
            height: 300,  // Fixed height for the list
            child: ListView.builder(
              itemCount: icons.length,  // Number of items in the list
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    log('${text[index]} Item Taped');  // Log a message when an item is tapped
                  },
                  child: Container(
                    margin: const EdgeInsets.all(3),  // Margin around each ListTile
                    child: ListTile(
                      leading: Icon(
                        icons[index],  // Icon for the ListTile
                        size: 30,  // Size of the icon
                        color: Colors.white,  // Icon color
                      ),
                      title: Text(
                        text[index],  // Label for the ListTile
                        style: const TextStyle(
                          color: Colors.white,  // Text color
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
