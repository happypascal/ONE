import 'package:flutter/material.dart';

class CustomProgressIndicator extends StatelessWidget {
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator.adaptive(),
    );
  }
}

class CustomWrapper extends StatelessWidget {
  final Widget child;

  CustomWrapper({required this.child});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
        child: child,
      ),
    );
  }
}
