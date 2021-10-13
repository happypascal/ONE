import 'package:flutter/material.dart';
import 'routes/appRoutes.dart';
import 'package:provider/provider.dart';
import 'providers/settings.dart';
import 'providers/connect.dart';
import 'package:humidor_one_by_favre/utils/const.dart';

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
        ChangeNotifierProxyProvider<Settings, Connect>(
          create: (ctx) => Connect(Const.DEFAULT_ADDRESS),
          update: (ctx, settings, connect) => Connect(settings.address),
        ),
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
