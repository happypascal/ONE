import 'package:flutter/material.dart';
import 'package:humidor_one_by_favre/routes/appRoutes.dart';

class ConnectionError extends StatelessWidget {
  final String? error;
  ConnectionError(this.error);

  final String unknownError = 'unknown error';

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Connection error: ${error ?? unknownError}',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context)
                .pushReplacementNamed(AppRoutes.SETTINGS_SCREEN);
          },
          child: Text('Reconnect'),
        ),
      ],
    );
  }
}
