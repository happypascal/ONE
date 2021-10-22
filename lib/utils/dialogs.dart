import 'package:flutter/material.dart';

class Dialogs {
  static Future<bool> confirmExitDialog(BuildContext context) async {
    bool res = false;
    await showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: Text(
              'Exit',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
            content: Text('Close the app?'),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();

                    res = true;
                  },
                  child: Text('Yes')),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    res = false;
                  },
                  child: Text('Cancel'))
            ],
          );
        });
    return res;
  }
}
