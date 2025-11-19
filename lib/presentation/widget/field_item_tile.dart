import 'package:flutter/material.dart';
import 'package:dynamic_form/data/model/field_model.dart';
import 'field_actions.dart';

class FieldItemTile extends StatelessWidget {
  final FieldModel field;

  const FieldItemTile({super.key, required this.field});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        field.label,
        style: const TextStyle(fontSize: 16),
      ),
      subtitle: Text(field.type.toString().split(".").last),
      trailing: FieldActions(field: field),
    );
  }
}
