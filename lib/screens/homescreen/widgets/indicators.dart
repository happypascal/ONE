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
  initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Consumer<DeviceData>(
      builder: (ctx, data, _) {
        if (data.client == null) {
          return ConnectionError(
              'Device was disconnected. Error: ${data.error}. Try to reconnect. ');
        }

        ///TODO:reading is hidden because coils is not ready on PLC side
        //Provider.of<DeviceData>(context, listen: false).readData();
        return Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Humidity(),
              SizedBox(height: 30.0),
              Temperature(),
              SizedBox(height: 30.0),
              OpenCloseButton(),
            ],
          ),
        );
      },
    );
  }
}
