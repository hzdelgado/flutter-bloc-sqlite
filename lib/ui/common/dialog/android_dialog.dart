import 'package:flutter/material.dart';
import 'package:flutter_bloc_sqlite/ui/common/dialog/dialog.dart';
import 'package:flutter_bloc_sqlite/ui/widgets/edit_task_dialog/edit_task_dialog_content.dart';
import 'package:flutter_bloc_sqlite/ui/widgets/edit_task_dialog/edit_task_dialog_title.dart';

class AndroidDialog extends CustomDialog {
  @override
  Widget create(BuildContext context, Function onPressed) {
    final TextEditingController ctlr = TextEditingController();
    final formKey = GlobalKey<FormState>();
    return AlertDialog(
      backgroundColor: Colors.white,
      title: const EditTaskDialogTitle(),
      content: EditTaskDialogContent(ctlr, formKey),
      actions: [
        TextButton(
            child: const Text("Close"),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        TextButton(
          onPressed: () {
            if(formKey.currentState!.validate()) {
              onPressed(ctlr.text.trim());
            }
          },
          child: const Text("Accept"),
        ),
      ],
    );
  }
}
