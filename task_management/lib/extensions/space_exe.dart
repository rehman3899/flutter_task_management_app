import 'package:flutter/material.dart';

// Extension on nullable int (int?) to add custom methods and properties
extension IntExtension on int? {

  // Method to validate the nullable int. If it's null, returns the provided default value (default is 0).
  int validate({int value = 0}) {
    return this ?? value;
  }

  // Getter that returns a SizedBox with the specified height (converts the nullable int to a double).
  // If the int is null, the height will be null, and SizedBox will have no height.
  Widget get h => SizedBox(
    height: this?.toDouble(),
  );

  // Getter that returns a SizedBox with the specified width (converts the nullable int to a double).
  // If the int is null, the width will be null, and SizedBox will have no width.
  Widget get w => SizedBox(
    width: this?.toDouble(),
  );
}
