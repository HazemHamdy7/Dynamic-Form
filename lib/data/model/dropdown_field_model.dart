import 'package:dynamic_form/data/model/field_type.dart';

class DropdownFieldModel extends FieldModel {
  List<String> options;

  DropdownFieldModel({super.id, required super.label, required this.options})
    : super(type: FieldType.dropdown);

  @override
  Map<String, dynamic> toMap() {
    return {'id': id, 'label': label, 'type': type.name, 'options': options};
  }

  factory DropdownFieldModel.fromMap(Map<String, dynamic> map) {
    return DropdownFieldModel(
      id: map['id'],
      label: map['label'],
      options: List<String>.from(map['options']),
    );
  }
}
