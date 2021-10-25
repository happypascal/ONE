import 'package:flutter/material.dart';
import 'package:humidor_one_by_favre/common/commonWidgets.dart';
import 'package:humidor_one_by_favre/routes/appRoutes.dart';
import 'package:humidor_one_by_favre/screens/settings/widgets/cancelButton.dart';
import 'package:provider/provider.dart';
import 'package:humidor_one_by_favre/providers/settings.dart';
import 'package:humidor_one_by_favre/providers/deviceData.dart';
import 'widgets/addressPart.dart';
import 'widgets/dot.dart';
import 'package:humidor_one_by_favre/utils/dialogs.dart';

class SettingsScreen extends StatefulWidget {
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final _key = GlobalKey<FormState>();
  final TextEditingController _addrCtrl_0 = TextEditingController();
  final TextEditingController _addrCtrl_1 = TextEditingController();
  final TextEditingController _addrCtrl_2 = TextEditingController();
  final TextEditingController _addrCtrl_3 = TextEditingController();

  String _address = '';

  initState() {
    super.initState();
    _address = Provider.of<Settings>(context, listen: false).address;
    var splitted =
        Provider.of<Settings>(context, listen: false).address.split('.');
    if (splitted.length == 4) {
      _addrCtrl_0.text = splitted[0];
      _addrCtrl_1.text = splitted[1];
      _addrCtrl_2.text = splitted[2];
      _addrCtrl_3.text = splitted[3];
    }
  }

  String? _validate(String? val) {
    var res;

    if (val == null || val == '') {
      res = 'Fill';
    } else {
      var splitted = val.split('.');

      for (var element in splitted) {
        if (int.tryParse(element) == null) {
          return 'Should contain digits only';
        } else {}
      }
    }

    return res;
  }

  _saveForm() async {
    var isValid = _key.currentState!.validate();
    if (isValid) {
      //to stop already reading data in case existing connection
      Provider.of<DeviceData>(context, listen: false).stopTimer();
      _address = '';
      _key.currentState!.save();
      await Provider.of<Settings>(context, listen: false).saveAddress(_address);
      Navigator.of(context).pushReplacementNamed(AppRoutes.HOME_SCREEN);
    }
  }

  _updateAddress(String? val) {
    if (_address != '') {
      _address = _address + '.' + val!;
    } else {
      _address = val!;
    }
  }

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
                    needSettingsBtn: false,
                  ),
                  Indicator(
                      title: 'Enter IP address',
                      child: Column(
                        children: [
                          LayoutBuilder(
                            builder: (ctx, constraints) {
                              return Form(
                                key: _key,
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    AddressPart(constraints.maxWidth * 0.2,
                                        _validate, _addrCtrl_0, _updateAddress),
                                    Dot(),
                                    AddressPart(constraints.maxWidth * 0.2,
                                        _validate, _addrCtrl_1, _updateAddress),
                                    Dot(),
                                    AddressPart(constraints.maxWidth * 0.2,
                                        _validate, _addrCtrl_2, _updateAddress),
                                    Dot(),
                                    AddressPart(constraints.maxWidth * 0.2,
                                        _validate, _addrCtrl_3, _updateAddress),
                                  ],
                                ),
                              );
                            },
                          ),
                          SizedBox(height: 30.0),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CancelButton(),
                              InkWell(
                                onTap: _saveForm,
                                child: Image.asset(
                                  'assets/validate.png',
                                  width: 60.0,
                                  height: 60.0,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ))
                ],
              ),
            )),
      ),
    );
  }
}
