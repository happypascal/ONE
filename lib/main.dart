import 'package:flutter/material.dart';
import 'routes/appRoutes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'One by Favre',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      routes: AppRoutes.getRoutes(),
      initialRoute: AppRoutes.initialRoute(),
    );
  }
}
