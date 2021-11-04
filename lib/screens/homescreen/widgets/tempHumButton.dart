import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:humidor_one_by_favre/providers/deviceData.dart';
import 'package:humidor_one_by_favre/utils/scaffoldMessage.dart';

class TempHumButton extends StatefulWidget {
  final int address;
  final String imagePath;
  TempHumButton(this.address, this.imagePath);

  @override
  State<TempHumButton> createState() => _TempHumButtonState();
}

class _TempHumButtonState extends State<TempHumButton> {
  Widget build(BuildContext context) {
    bool isWriting = Provider.of<DeviceData>(context).isWriting;
    var height = MediaQuery.of(context).size.height;
    return LayoutBuilder(builder: (ctx, constraints) {
      return Opacity(
        opacity: isWriting ? 0.3 : 1,
        child: InkWell(
          enableFeedback: false,
          child: Image.asset(widget.imagePath,
              height: height > 650 ? 60.0 : 40.0, fit: BoxFit.fitHeight),
          onTap: isWriting
              ? null
              : () {
                  _onTap();
                },
        ),
      );
    });
  }

  _onTap() async {
    var msg = await Provider.of<DeviceData>(context, listen: false)
        .writeData(widget.address);

    if (msg != null) {
      ScaffoldMessage.showErrorMessage(context, msg);
    }
  }
}
