import 'package:flutter/material.dart';
import 'package:humidor_one_by_favre/screens/homescreen/widgets/customAppBar.dart';
import 'package:humidor_one_by_favre/screens/homescreen/widgets/temperature.dart';
import 'package:provider/provider.dart';
import 'package:humidor_one_by_favre/providers/connect.dart';
import 'package:humidor_one_by_favre/common/commonWidgets.dart';
import 'widgets/connectionError.dart';
import 'widgets/indicators.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        //TODO implement dialog ask exit app
        return true;
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
                CustomAppBar(),
                SizedBox(height: 30.0),
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
