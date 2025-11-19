import 'package:flutter/material.dart';

class FieldNameInput extends StatelessWidget {
  final TextEditingController controller;

  const FieldNameInput({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: const InputDecoration(labelText: "Field Name"),
    );
  }
}
