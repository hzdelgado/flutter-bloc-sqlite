import 'package:flutter/material.dart';

class EditTaskDialogContent extends StatelessWidget {
  final TextEditingController controller;
  final GlobalKey<FormState> form;
  const EditTaskDialogContent(this.controller, this.form, {super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
        key: form,
        child: Column(
          children: [
            const Text(
              "Enter a new value:",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey),
            ),
            const SizedBox(
              height: 10,
            ),
            Material(
                child: TextFormField(
              controller: controller,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Enter a value';
                }
              },
              decoration: InputDecoration(
                  hintStyle: const TextStyle(
                    color: Colors.grey,
                    fontSize: 18,
                  ),
                  suffixIcon: IconButton(
                    icon: const Icon(
                      Icons.cancel,
                      color: Colors.deepPurple,
                    ),
                    onPressed: () => controller.clear(),
                  )),
            ))
          ],
        ));
  }
}
