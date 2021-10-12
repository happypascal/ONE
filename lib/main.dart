import 'package:flutter/material.dart';
import 'routes/appRoutes.dart';
import 'package:provider/provider.dart';
import 'providers/settings.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Settings(),
        ),
        ChangeNotifierProxyProvider(create: create, update: update)
      ],
      child: MaterialApp(
        title: 'One by Favre',
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
        ),
        routes: AppRoutes.getRoutes(),
        initialRoute: AppRoutes.initialRoute(),
      ),
    );
  }
}
