import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:humidor_one_by_favre/providers/deviceData.dart';
import 'package:humidor_one_by_favre/utils/const.dart';
import 'package:humidor_one_by_favre/utils/scaffoldMessage.dart';

class OpenCloseButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool openCloseState = Provider.of<DeviceData>(context).openCloseState;
    return Column(
      children: [
        InkWell(
          child: Image.asset(
            openCloseState ? Const.IMAGE_CLOSE : Const.IMAGE_OPEN,
            height: 80.0,
            width: 80.0,
          ),
          onTap: () {
            _onTap(context);
          },
        )
      ],
    );
  }

  _onTap(BuildContext context) async {
    var msg = await Provider.of<DeviceData>(context, listen: false)
        .writeData(Const.OPEN_CLOSE_SET);

    if (msg != null) {
      ScaffoldMessage.showErrorMessage(context, msg);
    }
  }
}
