import 'package:flutter/material.dart';
import 'package:humidor_one_by_favre/providers/connect.dart';
import 'package:humidor_one_by_favre/routes/appRoutes.dart';
import 'package:humidor_one_by_favre/utils/scaffoldMessage.dart';
import 'package:provider/provider.dart';

class CancelButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (Provider.of<Connect>(context, listen: false).address != '') {
          Navigator.of(context).pushReplacementNamed(AppRoutes.HOME_SCREEN);
        } else {
          ScaffoldMessage.showErrorMessage(
              context, 'No saved address. Enter IP address.');
        }
      },
      child: Image.asset(
        'assets/cancel.png',
        width: 60.0,
        height: 60.0,
      ),
    );
  }
}
