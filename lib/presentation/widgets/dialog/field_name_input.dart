import 'package:flutter/material.dart';

class FieldNameInput extends StatelessWidget {
  final TextEditingController labelController;

  const FieldNameInput({super.key, required this.labelController});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: labelController,
      decoration: const InputDecoration(labelText: "Field Name"),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return "Field name cannot be empty";
        }
        return null;
      },
    );
  }
}
