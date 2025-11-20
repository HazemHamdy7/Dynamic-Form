import 'package:dynamic_form/data/model/field_type.dart';

class RadioFieldModel extends FieldModel {
  List<String> options;

  RadioFieldModel({super.id, required super.label, required this.options})
    : super(type: FieldType.radio);

  @override
  Map<String, dynamic> toMap() {
    return {'id': id, 'label': label, 'type': type.name, 'options': options};
  }

  factory RadioFieldModel.fromMap(Map<String, dynamic> map) {
    return RadioFieldModel(
      id: map['id'],
      label: map['label'],
      options: List<String>.from(map['options']),
    );
  }
}
