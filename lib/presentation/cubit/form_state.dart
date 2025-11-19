import 'package:dynamic_form/data/model/field_model.dart';

class DynamicFormState {
  final List<FieldModel> fields;
  final Map<String, dynamic> answers;

  DynamicFormState({required this.fields, required this.answers});

  DynamicFormState copyWith({
    List<FieldModel>? fields,
    Map<String, dynamic>? answers,
  }) {
    return DynamicFormState(
      answers: answers ?? this.answers,
      fields: fields ?? this.fields,
    );
  }
}
