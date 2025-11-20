// import 'dart:developer';
// import 'package:dynamic_form/data/factory/factory_model.dart';
// import 'package:dynamic_form/data/model/field_type.dart';
//  import 'package:dynamic_form/data/repository/form_repository.dart';
// import 'package:dynamic_form/presentation/cubit/form_state.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class FormCubit extends Cubit<DynamicFormState> {
//   final FormRepository repository;

//   FormCubit(this.repository)
//       : super(DynamicFormState(fields: [], answers: {})) {
//     loadFields();
//   }

//   // =============================================================
//   // LOAD FIELDS FROM HIVE
//   // =============================================================
//   Future<bool> loadFields() async {
//     try {
//       final saved = await repository.loadFields();
//       if (saved == null) return true;

//       final models = saved.map((m) => FieldFactory.fromMap(m)).toList();
//       emit(state.copyWith(fields: models));
//       return true;
//     } catch (e, s) {
//       log("❌ Error loading fields: $e", stackTrace: s);
//       return false;
//     }
//   }

//   // =============================================================
//   // SAVE TO HIVE (WITH ERROR HANDLING)
//   // =============================================================
//   Future<bool> persist() async {
//     try {
//       final maps = state.fields.map((e) => e.toMap()).toList();
//       await repository.saveFields(maps);
//       return true;
//     } catch (e, s) {
//       log("❌ Error saving fields: $e", stackTrace: s);
//       return false;
//     }
//   }

//   // =============================================================
//   // ADD FIELD
//   // =============================================================
//   Future<bool> addField(FieldModel field) async {
//     try {
//       final fields = [...state.fields, field];
//       emit(state.copyWith(fields: fields));
//       return await persist();
//     } catch (e, s) {
//       log("❌ Error adding field: $e", stackTrace: s);
//       return false;
//     }
//   }

//   // =============================================================
//   // REMOVE FIELD
//   // =============================================================
//   Future<bool> removeField(String id) async {
//     try {
//       final fields = state.fields.where((f) => f.id != id).toList();
//       emit(state.copyWith(fields: fields));
//       return await persist();
//     } catch (e, s) {
//       log("❌ Error removing field: $e", stackTrace: s);
//       return false;
//     }
//   }

//   // =============================================================
//   // UPDATE FIELD
//   // =============================================================
//   Future<bool> updateField(FieldModel updatedField) async {
//     try {
//       final fields = state.fields
//           .map((f) => f.id == updatedField.id ? updatedField : f)
//           .toList();

//       emit(state.copyWith(fields: fields));
//       return await persist();
//     } catch (e, s) {
//       log("❌ Error updating field: $e", stackTrace: s);
//       return false;
//     }
//   }

//   // =============================================================
//   // CLEAR ALL FIELDS
//   // =============================================================
//   Future<bool> clearForm() async {
//     try {
//       emit(state.copyWith(fields: []));
//       return await persist();
//     } catch (e, s) {
//       log("❌ Error clearing fields: $e", stackTrace: s);
//       return false;
//     }
//   }

//   // =============================================================
//   // SAVE ANSWERS (TEXT / DROPDOWN / RADIO)
//   // =============================================================
//   Future<void> saveText(String fieldId, String value) async {
//     final answers = {...state.answers, fieldId: value};
//     emit(state.copyWith(answers: answers));
//   }

//   Future<void> saveDropdown(String fieldId, String? value) async {
//     final answers = {...state.answers, fieldId: value};
//     emit(state.copyWith(answers: answers));
//   }

//   Future<void> saveRadio(String fieldId, String? value) async {
//     final answers = {...state.answers, fieldId: value};
//     emit(state.copyWith(answers: answers));
//   }
// }
