import 'package:flutter/material.dart';
import 'package:dynamic_form/data/model/field_type.dart';
 
import 'preview_field_widget.dart';

class PreviewTile extends StatelessWidget {
  final FieldModel field;

  const PreviewTile({super.key, required this.field});

  @override
  Widget build(BuildContext context) {
    IconData icon;

    switch (field.type) {
      case FieldType.text:
        icon = Icons.text_fields;
        break;
      case FieldType.dropdown:
        icon = Icons.arrow_drop_down_circle_outlined;
        break;
      case FieldType.radio:
        icon = Icons.radio_button_checked;
        break;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 3),
            blurRadius: 10,
            spreadRadius: 1,
            color: Colors.black12,
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.deepPurple),
              const SizedBox(width: 8),
              Text(
                field.label,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          PreviewFieldWidget(field: field),
        ],
      ),
    );
  }
}
