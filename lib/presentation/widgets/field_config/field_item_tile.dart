import 'package:dynamic_form/data/model/field_type.dart';
import 'package:flutter/material.dart';

typedef EditCallback = void Function(FieldModel field);
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
    final label = {
      FieldType.text: "Text Field",
      FieldType.dropdown: "Dropdown Field",
      FieldType.radio: "Radio Field",
    };

    return Card(
      elevation: 2,
      // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 10,
        ),
        title: Text(
          field.label,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(label[field.type]!),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.blue),
              onPressed: () => onEdit(field),
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () => onDelete(field.id),
            ),
          ],
        ),
      ),
    );
  }
}
