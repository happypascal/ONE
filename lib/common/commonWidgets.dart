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

class Indicator extends StatelessWidget {
  final Widget child;
  final String title;
  Indicator({
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LayoutBuilder(
          builder: (ctx, constraints) {
            return Container(
              height: 30.0,
              width: constraints.maxWidth * 0.7,
              padding: const EdgeInsets.only(top: 6.0, left: 10.0, right: 10.0),
              decoration: BoxDecoration(
                color: Color(0x77000000),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              child: Center(
                child: Text(
                  title.toUpperCase(),
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            );
          },
        ),
        Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Color(0x77000000),
            borderRadius: BorderRadius.all(Radius.circular(40.0)),
          ),
          child: child,
        )
      ],
    );
  }
}
