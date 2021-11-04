import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:humidor_one_by_favre/providers/deviceData.dart';
import 'package:humidor_one_by_favre/utils/const.dart';
import 'package:humidor_one_by_favre/utils/scaffoldMessage.dart';

class OpenCloseButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DeviceData deviceData = Provider.of<DeviceData>(context);
    bool openCloseState = deviceData.openCloseState;
    bool isWriting = deviceData.isWriting;
    return LayoutBuilder(builder: (ctx, constraints) {
      return Opacity(
        opacity: isWriting ? 0.3 : 1,
        child: InkWell(
          enableFeedback: false,
          child: Image.asset(
            openCloseState ? Const.IMAGE_CLOSE : Const.IMAGE_OPEN,
            width: constraints.maxHeight * 0.8,
          ),
          onTap: isWriting
              ? null
              : () {
                  _onTap(context);
                },
        ),
      );
    });
  }

  _onTap(BuildContext context) async {
    var msg = await Provider.of<DeviceData>(context, listen: false)
        .writeData(Const.OPEN_CLOSE_SET, readWithOutWaiting: false);

    if (msg != null) {
      ScaffoldMessage.showErrorMessage(context, msg);
    }
  }
}
