import 'package:dynamic_form/data/model/field_model.dart';
import 'package:flutter/material.dart';

class FieldTypeSelector extends StatelessWidget {
  final FieldType value;
  final void Function(FieldType?) onChanged;

  const FieldTypeSelector({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<FieldType>(
      value: value,
      decoration: const InputDecoration(labelText: "Field Type"),
      items: FieldType.values
          .map(
            (type) => DropdownMenuItem(
              value: type,
              child: Text(type.toString().split('.').last),
            ),
          )
          .toList(),
      onChanged: onChanged,
    );
  }
}
