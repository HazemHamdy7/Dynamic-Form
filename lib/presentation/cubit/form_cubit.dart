import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dynamic_form/data/model/field_model.dart';
import 'package:dynamic_form/presentation/cubit/form_state.dart';

class FormCubit extends Cubit<DynamicFormState> {
  FormCubit() : super(DynamicFormState(fields: []));

  void addField(FieldModel field) {
    final fields = List<FieldModel>.from(state.fields)..add(field);
    emit(state.copyWith(fields: fields));
    // emit(state.copyWith(fields: [...state.fields, field]));
  }

  void removeField(String id) {
    final fields = state.fields.where((element) => element.id != id).toList();
    emit(state.copyWith(fields: fields));

    // emit(
    //   state.copyWith(
    //     fields: state.fields.where((element) => element != field).toList()
    //   ),
    // );
  }

  void updateField(FieldModel updatedField) {
    final fields = state.fields
        .map((field) => field.id == updatedField.id ? updatedField : field)
        .toList();

    emit(state.copyWith(fields: fields));
    // emit(
    //   state.copyWith(
    //     fields: state.fields.map((e) => e == updatedField ? updatedField : e).toList(),
    //   ),
    // );
  }

  void clearForm() {
    emit(state.copyWith(fields: []));
  }
}
