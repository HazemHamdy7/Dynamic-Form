import 'package:uuid/uuid.dart';

enum FieldType { text, dropdown, radio }

abstract class FieldModel {
  final String id;
  String label;
  final FieldType type;

  FieldModel({String? id, required this.label, required this.type})
    : id = id ?? const Uuid().v4();

  Map<String, dynamic> toMap();
}

class TextFieldModel extends FieldModel {
  TextFieldModel({super.id, required super.label})
    : super(type: FieldType.text);

  @override
  Map<String, dynamic> toMap() {
    return {'id': id, 'label': label, 'type': 'text'};
  }
}

class DropdownFieldModel extends FieldModel {
  List<String> options;

  DropdownFieldModel({super.id, required super.label, required this.options})
    : super(type: FieldType.dropdown);

  @override
  Map<String, dynamic> toMap() {
    return {'id': id, 'label': label, 'type': 'dropdown', 'options': options};
  }
}

class RadioFieldModel extends FieldModel {
  List<String> options;

  RadioFieldModel({super.id, required super.label, required this.options})
    : super(type: FieldType.radio);

  @override
  Map<String, dynamic> toMap() {
    return {'id': id, 'label': label, 'type': 'radio', 'options': options};
  }
}

