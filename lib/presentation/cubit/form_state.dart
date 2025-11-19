import 'package:dynamic_form/data/model/field_model.dart';

class DynamicFormState {
  final List<FieldModel> fields;

  DynamicFormState({required this.fields});

  DynamicFormState copyWith({List<FieldModel>? fields}) {
    return DynamicFormState(fields: fields ?? this.fields);
  }
}
