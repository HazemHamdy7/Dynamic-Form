import 'package:dynamic_form/data/model/field_model.dart';

class FieldFactory {
  static FieldModel create(
    FieldType type, {
    String? id,
    required String label,
    List<String>? options,
  }) {
    switch (type) {
      case FieldType.text:
        return TextFieldModel(id: id, label: label);
      case FieldType.dropdown:
        return DropdownFieldModel(id: id, label: label, options: options!);
      case FieldType.radio:
        return RadioFieldModel(id: id, label: label, options: options!);
    }
  }
}
