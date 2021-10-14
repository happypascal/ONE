import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:humidor_one_by_favre/providers/deviceData.dart';
import 'package:humidor_one_by_favre/utils/const.dart';

class OpenCloseButton extends StatelessWidget {
  const OpenCloseButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            Provider.of<DeviceData>(context, listen: false)
                .writeData(Const.OPEN_CLOSE, data: true);
          },
          child: Text('Open'),
        ),
        TextButton(
          onPressed: () {
            Provider.of<DeviceData>(context, listen: false)
                .writeData(Const.OPEN_CLOSE, data: false);
          },
          child: Text('Close'),
        ),
      ],
    );
  }
}
