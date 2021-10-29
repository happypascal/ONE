import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:humidor_one_by_favre/providers/connect.dart';
import 'package:humidor_one_by_favre/common/commonWidgets.dart';
import 'widgets/connectionError.dart';
import 'widgets/indicators.dart';
import 'package:humidor_one_by_favre/utils/dialogs.dart';

class HomeScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    print('debug screen height $height');
    return WillPopScope(
      onWillPop: () async {
        return await Dialogs.confirmExitDialog(context);
      },
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                'assets/background.png',
              ),
              fit: BoxFit.cover),
        ),
        child: Scaffold(
          body: CustomWrapper(
            child: Flex(
              direction: Axis.vertical,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 80.0,
                  child: CustomAppBar(
                    needSettingsBtn: true,
                  ),
                ),
                Flexible(
                  flex: 7,
                  fit: FlexFit.tight,
                  child: FutureBuilder<String?>(
                    future:
                        Provider.of<Connect>(context, listen: false).connect(),
                    builder: (ctx, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CustomProgressIndicator();
                      }

                      if (snapshot.hasError) {
                        return ConnectionError(snapshot.error.toString());
                      }
                      if (snapshot.data != null) {
                        return ConnectionError(snapshot.data);
                      }

                      return Indicators();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
