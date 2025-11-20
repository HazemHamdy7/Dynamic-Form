import 'package:uuid/uuid.dart';

enum FieldType { text, dropdown, radio }

abstract class FieldModel {
  final String id;
  String? label;
  final FieldType type;

  FieldModel({String? id, required this.type, required this.label})
    : id = id ?? const Uuid().v4();
  Map<String, dynamic> toMap(); 
}
