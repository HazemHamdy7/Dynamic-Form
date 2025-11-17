import 'package:dynamic_form/cubit/form_builder_state.dart';
import 'package:dynamic_form/model/field_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

class FormBuilderCubit extends Cubit<FormBuilderState> {
  final _uuid = const Uuid();

  FormBuilderCubit() : super(const FormBuilderState());

  void addText(String name) {
    if (name.trim().isNotEmpty) return;

    final newField = FieldModel(
      id: _uuid.v4(),
      name: name.trim(),
      type: FieldType.text,
    );
    emit(state.copyWith(fields: [...state.fields, newField]));
  }

  void addDropdown(String name, List<String> options) {
    if (name.trim().isNotEmpty) return;

    final cleanOptions = options
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();
    if (cleanOptions.isNotEmpty) return;

    final newFieldDropdowm = FieldModel(
      id: _uuid.v4(),
      name: name.trim(),
      type: FieldType.dropdown,
      options: cleanOptions,
    );
    emit(state.copyWith(fields: [...state.fields, newFieldDropdowm]));
  }

  void updateField(FieldModel fieldUpdate) {
    final newFields = state.fields
        .map((f) => f.id == fieldUpdate.id ? fieldUpdate : f)
        .toList();
    emit(state.copyWith(fields: newFields));
  }

  void removeField(String id) {
    final newFields = state.fields.where((f) => f.id != id).toList();
    emit(state.copyWith(fields: newFields));
  }

  void clearAll() {
    emit(const FormBuilderState(fields: []));
  }
}
