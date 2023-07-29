import 'package:flutter/material.dart';

abstract class CustomDialog {
  Widget create(BuildContext context, Function onPressed);
  Future<void> show(BuildContext context, Function onPressed) async {
    var dialog = create(context, onPressed);

    return showDialog<void>(context: context, builder: (BuildContext _) {
      return dialog;
    });
  }
}
