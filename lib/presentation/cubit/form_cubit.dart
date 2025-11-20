import 'package:dynamic_form/data/factory/factory_model.dart';
import 'package:dynamic_form/data/model/field_type.dart';
import 'package:dynamic_form/data/repository/form_repository.dart';
import 'package:dynamic_form/presentation/cubit/form_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FormCubit extends Cubit<DynamicFormState> {
  final FormRepository repository;

  FormCubit(this.repository)
    : super(DynamicFormState(fields: [], answers: {})) {
    loadFields();
  }

  Future<void> loadFields() async {
    final saved = await repository.loadFields();
    if (saved == null) return;

    final models = saved.map((m) => FieldFactory.fromMap(m)).toList();
    emit(state.copyWith(fields: models));
  }

  Future<void> persist() async {
    final maps = state.fields.map((e) => e.toMap()).toList();
    await repository.saveFields(maps);
  }

  void addField(FieldModel field) {
    final fields = [...state.fields, field];
    emit(state.copyWith(fields: fields));
    persist();
  }

  void removeField(String id) {
    final fields = state.fields.where((f) => f.id != id).toList();
    emit(state.copyWith(fields: fields));
    persist();
  }

  void updateField(FieldModel updatedField) {
    final fields = state.fields
        .map((f) => f.id == updatedField.id ? updatedField : f)
        .toList();
    emit(state.copyWith(fields: fields));
    persist();
  }

  void clearForm() {
    emit(state.copyWith(fields: []));
    persist();
  }

  void saveText(String fieldId, String value) {
    final answers = {...state.answers, fieldId: value};
    emit(state.copyWith(answers: answers));
  }

  void saveDropdown(String fieldId, String? value) {
    final answers = {...state.answers, fieldId: value};
    emit(state.copyWith(answers: answers));
  }

  void saveRadio(String fieldId, String? value) {
    final answers = {...state.answers, fieldId: value};
    emit(state.copyWith(answers: answers));
  }
}
