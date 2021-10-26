import 'package:flutter/material.dart';

class AddressPart extends StatelessWidget {
  final double maxWidth;
  final String? Function(String?) validate;
  final addrCtrl;
  final Function(String?) updateAddress;
  final bool isValid;
  AddressPart(this.maxWidth, this.validate, this.addrCtrl, this.updateAddress,
      this.isValid);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: maxWidth,
      height: isValid ? 40.0 : 50.0,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(6.0),
            ),
            border: Border.all(
              width: 1.0,
              color: Colors.white,
            )),
        padding: EdgeInsets.all(isValid ? 6.0 : 2.0),
        alignment: Alignment.center,
        child: TextFormField(
          decoration: InputDecoration(border: InputBorder.none),
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16.0, color: Colors.white),
          validator: validate,
          controller: addrCtrl,
          keyboardType: TextInputType.number,
          onEditingComplete: () {
            FocusScope.of(context).nextFocus();
          },
          onSaved: updateAddress,
        ),
      ),
    );
  }
}
