import 'package:dynamic_form/data/model/field_type.dart';
import 'package:flutter/material.dart';

typedef EditCallback = void Function(FieldModel field);
typedef DeleteCallback = void Function(String fieldId);

class FieldItemTile extends StatelessWidget {
  final FieldModel field;
  final int index;
  final EditCallback onEdit;
  final DeleteCallback onDelete;

  const FieldItemTile({
    super.key,
    required this.field,
    required this.index,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: ListTile(
        leading: ReorderableDragStartListener(
          key: ValueKey("${field.id}_${field.label}_${field.hashCode}"),
          index: index,
          child: const Icon(Icons.drag_handle),
        ),
        title: Text(field.label),
        subtitle: Text(field.type.name),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(icon: Icon(Icons.edit), onPressed: () => onEdit(field)),
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
