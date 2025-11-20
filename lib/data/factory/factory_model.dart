import 'package:dynamic_form/data/model/dropdown_field_model.dart';
import 'package:dynamic_form/data/model/field_type.dart';
import 'package:dynamic_form/data/model/radio_field_model.dart';
import 'package:dynamic_form/data/model/text_field_model.dart';

class FieldFactory {
  static FieldModel create(
    FieldType type, {
    required String label,
    List<String>? options,
    String? id,
  }) {
    switch (type) {
      case FieldType.text:
        return TextFieldModel(id: id, label: label);

      case FieldType.dropdown:
        return DropdownFieldModel(id: id, label: label, options: options ?? []);

      case FieldType.radio:
        return RadioFieldModel(id: id, label: label, options: options ?? []);
    }
  }

  static FieldModel fromMap(Map<String, dynamic> map) {
    final type = FieldType.values.firstWhere((e) => e.name == map['type']);

    switch (type) {
      case FieldType.text:
        return TextFieldModel.fromMap(map);

      case FieldType.dropdown:
        return DropdownFieldModel.fromMap(map);

      case FieldType.radio:
        return RadioFieldModel.fromMap(map);
    }
  }
}
