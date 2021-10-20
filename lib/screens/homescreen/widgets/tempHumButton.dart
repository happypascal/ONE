import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:humidor_one_by_favre/providers/deviceData.dart';
import 'package:humidor_one_by_favre/utils/scaffoldMessage.dart';

class TempHumButton extends StatelessWidget {
  final int address;
  final String imagePath;
  TempHumButton(this.address, this.imagePath);

  Widget build(BuildContext context) {
    return InkWell(
      child: Image.asset(
        imagePath,
        width: 80.0,
        height: 80.0,
      ),
      onTap: () {
        _onTap(context);
      },
    );
  }

  _onTap(BuildContext context) async {
    var msg = await Provider.of<DeviceData>(context, listen: false)
        .writeData(address);

    if (msg != null) {
      ScaffoldMessage.showErrorMessage(context, msg);
    }
  }
}
