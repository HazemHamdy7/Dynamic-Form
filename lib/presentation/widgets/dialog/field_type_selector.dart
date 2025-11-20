import 'package:dynamic_form/data/model/field_type.dart';
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
    final labels = {
      FieldType.text: "Text ",
      FieldType.dropdown: "Dropdown Menu",
      FieldType.radio: "Radio Buttons",
    };
    return DropdownButtonFormField<FieldType>(
      borderRadius: BorderRadius.circular(8),
      dropdownColor: Colors.grey[200],
      decoration: InputDecoration(
        labelText: "Field Type",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
      key: ValueKey(value),
      initialValue: value,
      items: FieldType.values
          .map(
            (type) => DropdownMenuItem(value: type, child: Text(labels[type]!)),
          )
          .toList(),
      onChanged: onChanged,
    );
  }
}
