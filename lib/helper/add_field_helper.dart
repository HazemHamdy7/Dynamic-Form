import 'package:flutter/material.dart';
import 'package:dynamic_form/data/model/field_model.dart';
import 'package:dynamic_form/data/model/factory_model.dart';

class AddFieldHelper {
  // Show Error (SnackBar)
  static void showError(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  // Handle Add Option

  static void addOption({
    required BuildContext context,
    required List<TextEditingController> optionControllers,
    required VoidCallback onUpdate,
  }) {
    if (optionControllers.isEmpty ||
        optionControllers.last.text.trim().isNotEmpty) {
      optionControllers.add(TextEditingController());
      onUpdate();
    } else {
      showError(context, "Fill the last option first");
    }
  }

  // Handle Save

  static FieldModel? saveField({
    required BuildContext context,
    required String label,
    required FieldType type,
    required List<TextEditingController> optionControllers,
  }) {
    // 1) validate name
    if (label.trim().isEmpty) {
      showError(context, "Field name cannot be empty");
      return null;
    }

    // 2) Text field → return directly
    if (type == FieldType.text) {
      return FieldFactory.create(type, label: label.trim());
    }

    // 3) clean options (remove empty)
    final options = optionControllers
        .map((c) => c.text.trim())
        .where((o) => o.isNotEmpty)
        .toList();

    if (options.isEmpty) {
      showError(context, "Options cannot be empty");
      return null;
    }

    if (options.length < 2) {
      showError(context, "Please enter at least 2 options");
      return null;
    }

    // 4) return dropdown or radio
    return FieldFactory.create(type, label: label.trim(), options: options);
  }
}
