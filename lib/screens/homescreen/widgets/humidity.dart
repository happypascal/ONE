import 'package:flutter/material.dart';
import 'package:humidor_one_by_favre/common/commonWidgets.dart';
import 'package:humidor_one_by_favre/utils/const.dart';
import 'tempHumButton.dart';
import 'package:provider/provider.dart';
import 'package:humidor_one_by_favre/providers/deviceData.dart';

class Humidity extends StatelessWidget {
  const Humidity({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<DeviceData>(
      builder: (ctx, deviceData, _) {
        return Indicator(
          title: "Humidity",
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
                    child: Text(deviceData.humMeasure),
                  ),
                ),
                Flexible(
                  fit: FlexFit.tight,
                  flex: 1,
                  child: Container(
                    alignment: Alignment.center,
                    child: Text('%'),
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
                  child: TempHumButton(Const.HUM_MINUS, Const.IMAGE_MINUS),
                ),
                Flexible(
                  fit: FlexFit.tight,
                  flex: 3,
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(deviceData.humSet),
                  ),
                ),
                Flexible(
                  fit: FlexFit.tight,
                  flex: 1,
                  child: TempHumButton(Const.HUM_MINUS, Const.IMAGE_PLUS),
                ),
              ],
            )
          ],
        );
      },
    );
  }
}
