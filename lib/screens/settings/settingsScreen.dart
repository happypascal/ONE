import 'package:flutter/material.dart';
import 'package:humidor_one_by_favre/common/commonWidgets.dart';
import 'package:humidor_one_by_favre/routes/appRoutes.dart';
import 'package:humidor_one_by_favre/utils/const.dart';
import 'package:provider/provider.dart';
import 'package:humidor_one_by_favre/providers/settings.dart';

class SettingsScreen extends StatefulWidget {
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final _key = GlobalKey<FormState>();
  final TextEditingController _addrCtrl = TextEditingController();

  initState() {
    super.initState();
    _addrCtrl.text = Provider.of<Settings>(context, listen: false).address;
  }

  String? _validate(String? val) {
    var res;

    if (val == null || val == '') {
      res = 'Please fill';
    } else {
      var splitted = val.split('.');

      for (var element in splitted) {
        if (int.tryParse(element) == null) {
          return 'Should contain digits only';
        }
      }
    }

    return res;
  }

  _saveForm() {
    var isValid = _key.currentState!.validate();
    if (isValid) {
      _key.currentState!.save();
    }
  }

  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        //TODO implement dialog ask exit app
        return true;
      },
      child: Scaffold(
          appBar: AppBar(
            title: Text('Settings'),
          ),
          body: CustomWrapper(
            child: Column(
              children: [
                Text('Enter IP address'),
                SizedBox(height: 10.0),
                Form(
                  key: _key,
                  child: Column(
                    children: [
                      TextFormField(
                        validator: _validate,
                        controller: _addrCtrl,
                        keyboardType: TextInputType.number,
                        onSaved: (val) async {
                          await Provider.of<Settings>(context, listen: false)
                              .saveAddress(_addrCtrl.text);
                          Navigator.of(context)
                              .pushReplacementNamed(AppRoutes.HOME_SCREEN);
                        },
                      )
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: _saveForm,
                  child: Text('Save & Connect'),
                ),
              ],
            ),
          )),
    );
  }
}
