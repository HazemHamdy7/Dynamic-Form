import 'package:flutter/material.dart';
import 'package:dynamic_form/data/model/field_model.dart';

typedef EditCallback = Future<FieldModel?> Function(FieldModel field);
typedef DeleteCallback = void Function(String fieldId);

class FieldItemTile extends StatelessWidget {
  final FieldModel field;
  final EditCallback onEdit;
  final DeleteCallback onDelete;

  const FieldItemTile({
    super.key,
    required this.field,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(field.label),
      subtitle: Text(field.type.toString().split('.').last),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => onEdit(field),
          ),
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () => onDelete(field.id),
          ),
        ],
      ),
    );
  }
}
