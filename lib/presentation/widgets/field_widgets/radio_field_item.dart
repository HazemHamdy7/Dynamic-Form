import 'package:dynamic_form/data/model/radio_field_model.dart';
import 'package:dynamic_form/presentation/cubit/form_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RadioFieldItem extends StatelessWidget {
  final RadioFieldModel field;

  const RadioFieldItem({super.key, required this.field});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<FormCubit>();
    final options = field.options
        .where((option) => option.trim().isNotEmpty)
        .toList();

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: FormField<String>(
        validator: (value) {
          if (value == null) {
            return "Please select ${field.label}";
          }
          return null;
        },

        onSaved: (value) {
          cubit.saveRadio(field.id, value);
        },

        builder: (formFieldState) {
          final selected = cubit.state.answers[field.id];

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                field.label ?? '',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),

              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: options.length,
                itemBuilder: (context, index) {
                  final option = options[index];
                  return RadioListTile<String>(
                    title: Text(option),
                    value: option,
                    groupValue: selected,
                    onChanged: (value) {
                      cubit.saveRadio(field.id, value);
                      formFieldState.didChange(value);
                    },
                  );
                },
              ),
              if (formFieldState.hasError)
                Text(
                  formFieldState.errorText!,
                  style: const TextStyle(color: Colors.red),
                ),
            ],
          );
        },
      ),
    );
  }
}
