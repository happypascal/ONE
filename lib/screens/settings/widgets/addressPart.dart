import 'package:flutter/material.dart';

class AddressPart extends StatelessWidget {
  final double maxWidth;
  final String? Function(String?) validate;
  final addrCtrl;
  final Function(String?) updateAddress;
  AddressPart(
    this.maxWidth,
    this.validate,
    this.addrCtrl,
    this.updateAddress,
  );
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: maxWidth,
      height: 40.0,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(6.0),
            ),
            border: Border.all(
              width: 1.0,
              color: Colors.white,
            )),
        padding: const EdgeInsets.all(6.0),
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
