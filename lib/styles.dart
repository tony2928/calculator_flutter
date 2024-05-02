import 'package:flutter/material.dart';

class MyStyles {
  static ButtonStyle buttonStyle(BuildContext context) {
    return ElevatedButton.styleFrom(
      backgroundColor: Theme.of(context).colorScheme.background,
      elevation: 5,
      padding: const EdgeInsets.all(16),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
    );
  }

  static ButtonStyle operatorButtonStyle(BuildContext context) {
    return ElevatedButton.styleFrom(
      backgroundColor: Theme.of(context).colorScheme.background,
      elevation: 5,
      padding: const EdgeInsets.all(16),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
    );
  }

  static ButtonStyle clearButtonStyle(BuildContext context) {
    return ElevatedButton.styleFrom(
      backgroundColor: Theme.of(context).colorScheme.error,
      elevation: 5,
      padding: const EdgeInsets.all(16),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
    );
  }

  static ButtonStyle backspaceButtonStyle(BuildContext context) {
    return ElevatedButton.styleFrom(
      backgroundColor: Theme.of(context).colorScheme.error,
      elevation: 5,
      padding: const EdgeInsets.all(16),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
    );
  }

  static ButtonStyle resultButtonStyle(BuildContext context) {
    return ElevatedButton.styleFrom(
      backgroundColor: Theme.of(context).colorScheme.primary,
      elevation: 5,
      padding: const EdgeInsets.all(16),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
    );
  }

  static TextStyle buttonTextStyle = const TextStyle(
    fontSize: 24,
    color: Colors.white,
  );

  static operatorTextStyle(BuildContext context) {
    return TextStyle(
      fontSize: 24,
      color: Theme.of(context).colorScheme.primary,
    );
  }

  static TextStyle clearButtonTextStyle = const TextStyle(
    fontSize: 24,
    color: Colors.white,
  );

  static Icon backspaceIcon = const Icon(
    Icons.backspace_rounded,
    color: Colors.white,
    size: 34,
  );

  static Color? displayBackgroundColor = Colors.grey[800];
  // trying another color
  // static Color displayBackgroundColor = Colors.deepOrange;
}

