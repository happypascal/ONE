import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:humidor_one_by_favre/routes/appRoutes.dart';

class CustomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.horizontal,
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Flexible(
          flex: 1,
          fit: FlexFit.tight,
          child: InkWell(
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(AppRoutes.SETTINGS_SCREEN);
            },
            child: Image.asset('assets/setup.png'),
          ),
        ),
        Flexible(
          flex: 3,
          fit: FlexFit.tight,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 40.0, vertical: 40.0),
            child: Image.asset(
              'assets/logo.png',
            ),
          ),

          //TODO check or remove later
          // LayoutBuilder(
          //   builder: (context, constraints) {
          //     print('debug constraints.maxWidth: ${constraints.maxWidth}');
          //     return Container(
          //       constraints:
          //           BoxConstraints(maxWidth: constraints.maxWidth * 0.2),
          //       child: Image.asset(
          //         'assets/logo.png',
          //         width: 5.0,
          //       ),
          //     );
          //   },
          // ),
        ),
        Flexible(
          flex: 1,
          fit: FlexFit.tight,
          child: SizedBox(width: 1.0),
        )
      ],
    );
  }
}
