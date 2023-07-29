import 'package:flutter/material.dart';

class EditTaskDialogTitle extends StatelessWidget {
  const EditTaskDialogTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Text("Edit Task", style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color:  Colors.deepPurple.withOpacity(.7)));
  }
}