import 'package:flutter/material.dart';
import 'package:humidor_one_by_favre/providers/deviceData.dart';
import 'package:humidor_one_by_favre/routes/appRoutes.dart';
import 'package:provider/provider.dart';

class CustomProgressIndicator extends StatelessWidget {
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
            height: 26.0,
            width: 26.0,
            child: CircularProgressIndicator.adaptive(
              strokeWidth: 1.5,
            )),
        SizedBox(height: 10.0),
        Text(
          'Connecting',
          style: TextStyle(
            color: Colors.white,
          ),
          maxLines: 1,
          textDirection: TextDirection.ltr,
        )
      ],
    );
  }
}

class CustomWrapper extends StatelessWidget {
  final Widget child;

  CustomWrapper({required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
      child: child,
    );
  }
}

class Indicator extends StatelessWidget {
  final Widget child;
  final String title;

  Indicator({
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          flex: 1,
          fit: FlexFit.tight,
          child: LayoutBuilder(
            builder: (ctx, constraints) {
              return Container(
                height: 30.0,
                width: constraints.maxWidth * 0.7,
                padding:
                    const EdgeInsets.only(top: 6.0, left: 10.0, right: 10.0),
                decoration: BoxDecoration(
                  color: Color(0x77000000),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                ),
                child: Center(
                  child: Text(
                    title.toUpperCase(),
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(fontSize: constraints.maxWidth * 0.07),
                  ),
                ),
              );
            },
          ),
        ),
        Flexible(
          flex: 4,
          fit: FlexFit.tight,
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            decoration: BoxDecoration(
              color: Color(0x77000000),
              borderRadius: BorderRadius.all(Radius.circular(40.0)),
            ),
            child: child,
          ),
        ),
      ],
    );
  }
}

class CustomAppBar extends StatelessWidget {
  final bool needSettingsBtn;

  CustomAppBar({required this.needSettingsBtn});
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraints) {
      return Flex(
        direction: Axis.horizontal,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: needSettingsBtn
                ? InkWell(
                    onTap: () {
                      Provider.of<DeviceData>(context, listen: false)
                          .stopTimer();
                      Navigator.of(context)
                          .pushReplacementNamed(AppRoutes.SETTINGS_SCREEN);
                    },
                    child: Image.asset(
                      'assets/setup.png',
                      width:
                          (constraints.maxHeight * 0.8) > constraints.maxWidth
                              ? constraints.maxWidth * 0.9
                              : constraints.maxHeight * 0.8,
                      fit: BoxFit.fitHeight,
                    ),
                  )
                : SizedBox(width: 1.0),
          ),
          Flexible(
            flex: 3,
            fit: FlexFit.tight,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 40.0, vertical: 16.0),
              child: Image.asset(
                'assets/logo.png',
                height: (constraints.maxHeight * 0.8) > constraints.maxWidth
                    ? constraints.maxWidth * 0.9
                    : constraints.maxHeight * 0.8,
                fit: (constraints.maxHeight * 0.8) > constraints.maxWidth
                    ? BoxFit.contain
                    : BoxFit.contain,
              ),
            ),
          ),
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: SizedBox(width: 1.0),
          )
        ],
      );
    });
  }
}
