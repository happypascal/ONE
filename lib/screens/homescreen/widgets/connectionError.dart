import 'package:flutter/material.dart';

class ConnectionError extends StatelessWidget {
  final String? error;
  ConnectionError(this.error);

  final String unknownError = 'unknown error';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Connection error: ${error ?? unknownError}'),
    );
  }
}
