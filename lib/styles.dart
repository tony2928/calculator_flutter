import 'package:flutter/material.dart';

class MyStyles {
  static ButtonStyle buttonStyle(BuildContext context) {
    // return ButtonStyle(
    //   backgroundColor: MaterialStateProperty.all<Color>(
    //       Theme.of(context).colorScheme.secondary),
    //   elevation: MaterialStateProperty.all<double>(0),
    //   padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
    //     const EdgeInsets.all(16),
    //   ),
    //   textStyle: MaterialStateProperty.all<TextStyle>(
    //     const TextStyle(
    //       fontSize: 24,
    //       color: Colors.white,
    //     ),
    //   ),
    // );
    return ElevatedButton.styleFrom(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      elevation: 0,
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

  static Color? displayBackgroundColor = Colors.grey[800];
  // trying another color
  // static Color displayBackgroundColor = Colors.deepOrange;
}
