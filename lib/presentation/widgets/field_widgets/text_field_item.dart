import 'package:dynamic_form/presentation/cubit/form_cubit.dart';
import 'package:flutter/material.dart';
import 'package:dynamic_form/data/model/field_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TextFieldItem extends StatelessWidget {
  final TextFieldModel field;

  const TextFieldItem({super.key, required this.field});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<FormCubit>();

    return Padding(
      padding: EdgeInsets.only(bottom: 16),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: field.label,
          border: const OutlineInputBorder(),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "${field.label} is required";
          }
          return null;
        },

        onSaved: (value) {
          cubit.saveText(field.id, value ?? "");
        },
      ),
    );
  }
}
