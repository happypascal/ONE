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
    return LayoutBuilder(builder: (ctx, constraints) {
      return Column(
        children: [
          Flex(
            direction: Axis.horizontal,
            children: [
              Flexible(
                fit: FlexFit.tight,
                flex: 2,
                child: SizedBox(
                  width: 1.0,
                ),
              ),
              Flexible(
                fit: FlexFit.tight,
                flex: 4,
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    measureValue,
                    style: Theme.of(context)
                        .textTheme
                        .headline1!
                        .copyWith(fontSize: constraints.maxHeight * 0.4),
                  ),
                ),
              ),
              Flexible(
                fit: FlexFit.tight,
                flex: 2,
                child: Container(
                  child: Text(
                    label,
                    style: label == '\u00B0'
                        ? Theme.of(context)
                            .textTheme
                            .headline2!
                            .copyWith(fontSize: constraints.maxHeight * 0.4)
                        : Theme.of(context)
                            .textTheme
                            .headline2!
                            .copyWith(fontSize: constraints.maxHeight * 0.2),
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
                flex: 2,
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    setValue,
                    style: Theme.of(context)
                        .textTheme
                        .headline3!
                        .copyWith(fontSize: constraints.maxHeight * 0.25),
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
    });
  }
}
