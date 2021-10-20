import 'package:flutter/material.dart';
import 'package:humidor_one_by_favre/routes/appRoutes.dart';

class ScaffoldMessage {
  static showErrorMessage(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
        ),
        action: SnackBarAction(
          label: 'Settings',
          textColor: Colors.white,
          onPressed: () {
            Navigator.of(context)
                .pushReplacementNamed(AppRoutes.SETTINGS_SCREEN);
          },
        ),
      ),
    );
  }
}
