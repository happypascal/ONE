import 'package:flutter/material.dart';
import 'package:humidor_one_by_favre/screens/homescreen/widgets/connectionError.dart';
import 'package:provider/provider.dart';
import 'package:humidor_one_by_favre/providers/deviceData.dart';
import 'openCloseButton.dart';
import 'humidity.dart';
import 'temperature.dart';

class Indicators extends StatefulWidget {
  @override
  State<Indicators> createState() => _IndicatorsState();
}

class _IndicatorsState extends State<Indicators> {
  Widget build(BuildContext context) {
    return Consumer<DeviceData>(
      builder: (ctx, data, _) {
        if (data.client == null) {
          return ConnectionError(
              'Device was disconnected. Error: ${data.error}. Try to reconnect. ');
        }

        Provider.of<DeviceData>(context, listen: false).readData(context);
        return Container(
          width: double.infinity,
          child: Flex(
            direction: Axis.vertical,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(flex: 5, fit: FlexFit.tight, child: Humidity()),
              SizedBox(height: 16.0),
              Flexible(flex: 5, fit: FlexFit.tight, child: Temperature()),
              SizedBox(height: 16.0),
              Flexible(flex: 3, fit: FlexFit.tight, child: OpenCloseButton()),
            ],
          ),
        );
      },
    );
  }
}
