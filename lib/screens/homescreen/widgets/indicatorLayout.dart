import 'package:flutter/material.dart';

class IndicatorLayout extends StatelessWidget {
  final String measureValue;
  final String setValue;
  final String label;
  final Widget minusButton;
  final Widget plusButton;

  IndicatorLayout({
    required this.measureValue,
    required this.setValue,
    required this.label,
    required this.minusButton,
    required this.plusButton,
  });
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flex(
          direction: Axis.horizontal,
          children: [
            Flexible(
              fit: FlexFit.tight,
              flex: 1,
              child: SizedBox(
                width: 1.0,
              ),
            ),
            Flexible(
              fit: FlexFit.tight,
              flex: 3,
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  measureValue,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 50.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            Flexible(
              fit: FlexFit.tight,
              flex: 1,
              child: Container(
                child: Text(
                  label,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
              ),
            ),
          ],
        ),
        Flex(
          direction: Axis.horizontal,
          children: [
            Flexible(
              fit: FlexFit.tight,
              flex: 1,
              child: minusButton,
            ),
            Flexible(
              fit: FlexFit.tight,
              flex: 3,
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  setValue,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            Flexible(
              fit: FlexFit.tight,
              flex: 1,
              child: plusButton,
            ),
          ],
        )
      ],
    );
  }
}
