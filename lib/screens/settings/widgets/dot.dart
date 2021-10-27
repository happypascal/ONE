import 'package:flutter/material.dart';

class Dot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 2.0, right: 2.0, bottom: 10.0),
      alignment: Alignment.center,
      child: Text(
        '.',
        style: TextStyle(
          color: Color(0xffD5E9F4),
          fontSize: 20.0,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
