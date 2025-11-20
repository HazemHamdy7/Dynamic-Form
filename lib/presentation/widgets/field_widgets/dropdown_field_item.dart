import 'package:dynamic_form/data/model/dropdown_field_model.dart';
import 'package:dynamic_form/presentation/cubit/form_cubit.dart';
import 'package:flutter/material.dart';
 import 'package:flutter_bloc/flutter_bloc.dart';
 
class DropdownFieldItem extends StatelessWidget {
  final DropdownFieldModel field;

  const DropdownFieldItem({super.key, required this.field});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<FormCubit>();

    final options = field.options
        .where((options) => options.trim().isNotEmpty)
        .toList();
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: field.label,
          border: const OutlineInputBorder(),
        ),
        items: options
            .map(
              (option) => DropdownMenuItem(value: option, child: Text(option)),
            )
            .toList(),
        validator: (value) {
          if (value == null) return "Please select ${field.label}";
          return null;
        },

        onSaved: (value) {
          cubit.saveDropdown(field.id, value);
        },
        onChanged: (value) {
          cubit.saveDropdown(field.id, value);
        },
      ),
    );
  }
}
