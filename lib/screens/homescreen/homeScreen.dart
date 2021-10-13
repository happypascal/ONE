import 'package:flutter/material.dart';
import 'package:humidor_one_by_favre/screens/homescreen/widgets/customAppBar.dart';
import 'package:provider/provider.dart';
import 'package:humidor_one_by_favre/providers/connect.dart';
import 'package:humidor_one_by_favre/common/commonWidgets.dart';
import 'widgets/connectionError.dart';

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
        child: Scaffold(
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

                    return Center(child: Text('Connected'));
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
