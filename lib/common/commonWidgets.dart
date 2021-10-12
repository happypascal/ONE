import 'package:flutter/material.dart';

class CustomProgressIndicator extends StatelessWidget {
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator.adaptive(),
    );
  }
}
