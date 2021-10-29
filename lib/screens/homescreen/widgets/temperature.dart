import 'package:flutter/material.dart';
import 'package:humidor_one_by_favre/common/commonWidgets.dart';
import 'package:humidor_one_by_favre/utils/const.dart';
import 'tempHumButton.dart';
import 'package:provider/provider.dart';
import 'package:humidor_one_by_favre/providers/deviceData.dart';
import 'indicatorLayout.dart';

class Temperature extends StatelessWidget {
  const Temperature({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<DeviceData>(
      builder: (ctx, deviceData, _) {
        return Indicator(
          title: "Temperature",
          child: IndicatorLayout(
            measureValue: deviceData.tempMeasure,
            setValue: deviceData.tempSet,
            label: '\u00B0',
            minusButton: TempHumButton(
              Const.TEMP_MINUS,
              Const.IMAGE_MINUS,
            ),
            plusButton: TempHumButton(
              Const.TEMP_PLUS,
              Const.IMAGE_PLUS,
            ),
          ),
        );
      },
    );
  }
}
