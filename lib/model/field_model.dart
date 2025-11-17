import 'package:equatable/equatable.dart';

enum FieldType { text, dropdown }

class FieldModel extends Equatable {
  final String id;

  final String name;

  final FieldType type;

  final List<String> options;

  FieldModel({
    required this.id,
    required this.name,
    required this.type,
    List<String>? options,
  }) : options = options ?? [];
  FieldModel copyWith({
    String? id,
    String? name,
    FieldType? type,
    List<String>? options,
  }) {
    return FieldModel(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      options: options ?? this.options,
    );
  }

  @override
  List<Object?> get props => [id, name, type, options];
}
