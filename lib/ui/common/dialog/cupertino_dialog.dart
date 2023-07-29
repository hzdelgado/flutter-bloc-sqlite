import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc_sqlite/ui/common/dialog/dialog.dart';
import 'package:flutter_bloc_sqlite/ui/widgets/edit_task_dialog/edit_task_dialog_title.dart';

import '../../widgets/edit_task_dialog/edit_task_dialog_content.dart';

class IosDialog extends CustomDialog {
  @override
  Widget create(BuildContext context, Function onPressed) {
    final TextEditingController ctlr = TextEditingController();
    final formKey = GlobalKey<FormState>();
    return CupertinoAlertDialog(
      title: const EditTaskDialogTitle(),
      content: EditTaskDialogContent(ctlr, formKey),
      actions: [
        CupertinoButton(
            child: const Text("Close"),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        CupertinoButton(
          onPressed: () {
            if (formKey.currentState!.validate()) {
              onPressed(ctlr.text.trim());
            }
          },
          child: const Text("Accept"),
        ),
      ],
    );
  }
}
