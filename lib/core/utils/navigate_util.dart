import 'package:flutter/material.dart';

class NavigateUtil {
  void navigateToView(BuildContext context, Widget route) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => route),
    );
  }

  void navigateToViewClear(BuildContext context, Widget route) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => route,
      ),
      (route) => false,
    );
  }
}
