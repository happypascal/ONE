import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:humidor_one_by_favre/providers/connect.dart';
import 'package:humidor_one_by_favre/common/commonWidgets.dart';
import 'widgets/connectionError.dart';
import 'widgets/indicators.dart';
import 'package:humidor_one_by_favre/utils/dialogs.dart';

class HomeScreen extends StatelessWidget {
  Widget build(BuildContext context) {
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
          backgroundColor: Colors.transparent,
          body: CustomWrapper(
            child: Column(
              children: [
                CustomAppBar(
                  needSettingsBtn: true,
                ),
                SizedBox(height: 10.0),
                FutureBuilder<String?>(
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
