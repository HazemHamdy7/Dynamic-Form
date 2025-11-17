import 'package:dynamic_form/model/field_model.dart';
import 'package:equatable/equatable.dart';

class FormBuilderState extends Equatable {
  final List<FieldModel> fields;

  const FormBuilderState({this.fields = const []});

  FormBuilderState copyWith({List<FieldModel>? fields}) {
    return FormBuilderState(fields: fields ?? this.fields);
  }

  @override
  List<Object?> get props => [fields];
}
 