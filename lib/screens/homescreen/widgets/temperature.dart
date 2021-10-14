import 'package:flutter/material.dart';
import 'package:humidor_one_by_favre/common/commonWidgets.dart';

class Temperature extends StatelessWidget {
  const Temperature({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Indicator(
      title: "Temperature",
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
                child: Text('N/A'),
              ),
            ),
            Flexible(
              fit: FlexFit.tight,
              flex: 1,
              child: Container(
                alignment: Alignment.center,
                child: Text('deg'),
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
              child: ElevatedButton(
                child: Text('-'),
                onPressed: () {},
              ),
            ),
            Flexible(
              fit: FlexFit.tight,
              flex: 3,
              child: Container(
                alignment: Alignment.center,
                child: Text('N/A'),
              ),
            ),
            Flexible(
              fit: FlexFit.tight,
              flex: 1,
              child: ElevatedButton(
                child: Text('+'),
                onPressed: () {},
              ),
            ),
          ],
        )
      ],
    );
  }
}