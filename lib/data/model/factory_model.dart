import 'package:dynamic_form/data/model/field_model.dart';
import 'package:flutter/material.dart';

class FieldFactory {
  static FieldModel create(
    FieldType type, {
    required String label,
    List<String>? options,
    String? id,
  }) {
    switch (type) {
      case FieldType.text:
        return TextFieldModel(id: id ?? UniqueKey().toString(), label: label);

      case FieldType.dropdown:
        return DropdownFieldModel(
          id: id ?? UniqueKey().toString(),
          label: label,
          options: options ?? [],
        );

      case FieldType.radio:
        return RadioFieldModel(
          id: id ?? UniqueKey().toString(),
          label: label,
          options: options ?? [],
        );
    }
  }
}
