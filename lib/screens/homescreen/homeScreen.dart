import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:humidor_one_by_favre/providers/connect.dart';
import 'package:humidor_one_by_favre/common/commonWidgets.dart';
import 'widgets/connectionError.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _connect;

  initState() {
    super.initState();
    _connect = Provider.of<Connect>(context, listen: false).connect();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<String?>(
        future: _connect,
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
    );
  }
}
