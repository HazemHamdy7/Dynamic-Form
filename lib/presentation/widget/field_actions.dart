import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:dynamic_form/presentation/cubit/form_cubit.dart';
import 'package:dynamic_form/data/model/field_model.dart';
import 'package:dynamic_form/presentation/screens/add_field_dialog.dart';

class FieldActions extends StatelessWidget {
  final FieldModel field;

  const FieldActions({super.key, required this.field});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<FormCubit>();

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: const Icon(Icons.edit),
          onPressed: () async {
            final updated = await showDialog<FieldModel?>(
              context: context,
              builder: (_) => AddFieldDialog(editField: field),
            );

            if (updated != null) {
              cubit.updateField(updated);
            }
          },
        ),

        IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: () => cubit.removeField(field.id),
        ),
      ],
    );
  }
}
