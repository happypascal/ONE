import 'package:flutter/material.dart';
import 'package:humidor_one_by_favre/common/commonWidgets.dart';
import 'package:humidor_one_by_favre/utils/const.dart';
import 'tempHumButton.dart';
import 'package:provider/provider.dart';
import 'package:humidor_one_by_favre/providers/deviceData.dart';
import 'indicatorLayout.dart';

class Humidity extends StatelessWidget {
  const Humidity({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<DeviceData>(
      builder: (ctx, deviceData, _) {
        return Indicator(
          title: "Humidity",
          child: IndicatorLayout(
            measureValue: deviceData.humMeasure,
            setValue: deviceData.humSet,
            label: '%',
            minusButton: TempHumButton(
              Const.HUM_MINUS,
              Const.IMAGE_MINUS,
            ),
            plusButton: TempHumButton(
              Const.HUM_PLUS,
              Const.IMAGE_PLUS,
            ),
          ),
        );
      },
    );
  }
}
