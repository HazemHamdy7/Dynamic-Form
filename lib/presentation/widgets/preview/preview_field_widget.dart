import 'package:flutter/material.dart';
 import 'package:dynamic_form/data/model/dropdown_field_model.dart';
import 'package:dynamic_form/data/model/radio_field_model.dart';
import 'package:dynamic_form/data/model/field_type.dart';

class PreviewFieldWidget extends StatelessWidget {
  final FieldModel field;

  const PreviewFieldWidget({super.key, required this.field});

  @override
  Widget build(BuildContext context) {
    switch (field.type) {
      case FieldType.text:
        return TextField(
          enabled: false,
          decoration: InputDecoration(
            hintText: "Enter ${field.label}...",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
        );

      case FieldType.dropdown:
        final dropdown = field as DropdownFieldModel;

        return SizedBox(
          height: dropdown.options.length * 45,
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: dropdown.options.length,
            itemBuilder: (_, i) => ListTile(
              leading: const Icon(Icons.arrow_right, color: Colors.deepPurple),
              title: Text(dropdown.options[i]),
              contentPadding: EdgeInsets.zero,
              dense: true,
            ),
          ),
        );

      case FieldType.radio:
        final radio = field as RadioFieldModel;

        return SizedBox(
          height: radio.options.length * 45,
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: radio.options.length,
            itemBuilder: (_, i) => ListTile(
              leading: const Icon(Icons.radio_button_unchecked),
              title: Text(radio.options[i]),
              contentPadding: EdgeInsets.zero,
              dense: true,
            ),
          ),
        );
    }
  }
}
