import 'package:dynamic_form/data/model/field_type.dart';

class TextFieldModel extends FieldModel {
  TextFieldModel({super.id, required super.label})
    : super(type: FieldType.text);

  @override
  Map<String, dynamic> toMap() {
    return {'id': id, 'label': label, 'type': type.name};
  }

  factory TextFieldModel.fromMap(Map<String, dynamic> map) {
    return TextFieldModel(id: map['id'], label: map['label']);
  }
}
