import 'package:flutter/material.dart';
import 'routes/appRoutes.dart';
import 'package:provider/provider.dart';
import 'providers/settings.dart';
import 'providers/connect.dart';
import 'providers/deviceData.dart';
import 'package:humidor_one_by_favre/utils/const.dart';
import 'package:humidor_one_by_favre/common/commonWidgets.dart';

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
        ChangeNotifierProxyProvider<Connect, DeviceData>(
          create: (ctx) => DeviceData(null),
          update: (ctx, connect, deviceData) => DeviceData(connect.client),
        ),
      ],
      child: LoadSettings(),
    );
  }
}

class LoadSettings extends StatefulWidget {
  @override
  _LoadSettingsState createState() => _LoadSettingsState();
}

class _LoadSettingsState extends State<LoadSettings> {
  var _loadSettings;
  @override
  void initState() {
    super.initState();
    _loadSettings =
        Provider.of<Settings>(context, listen: false).loadSettings();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: _loadSettings,
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CustomProgressIndicator();
        }
        if (snapshot.data != null) {
          return App(AppRoutes.SETTINGS_SCREEN);
        }

        return App(AppRoutes.HOME_SCREEN);
      },
    );
  }
}

class App extends StatelessWidget {
  final String initialScreen;

  App(this.initialScreen);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'One by Favre',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      routes: AppRoutes.getRoutes(),
      initialRoute: AppRoutes.initialRoute(initialScreen),
    );
  }
}
