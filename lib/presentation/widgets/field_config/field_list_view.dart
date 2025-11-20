import 'package:dynamic_form/data/model/field_type.dart';
import 'package:dynamic_form/presentation/screens/add_field_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dynamic_form/presentation/cubit/form_cubit.dart';
import 'package:dynamic_form/presentation/cubit/form_state.dart';

import 'field_item_tile.dart';

class FieldListView extends StatelessWidget {
  const FieldListView({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<FormCubit>();

    return BlocBuilder<FormCubit, DynamicFormState>(
      builder: (context, state) {
        if (state.fields.isEmpty) {
          return const Center(
            child: Text(
              "No fields yet.\nTap the + button to add.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.all(12),
          itemCount: state.fields.length,
          separatorBuilder: (_, __) => const Divider(),
          itemBuilder: (context, index) {
            final field = state.fields[index];

            return FieldItemTile(
              field: field,

              onEdit: (field) async {
                final updatedField = await showDialog<FieldModel?>(
                  context: context,
                  builder: (_) => AddFieldDialog(editField: field),
                );

                if (updatedField != null) {
                  cubit.updateField(updatedField);

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Field updated successfully"),
                      backgroundColor: Colors.green,
                    ),
                  );
                }
              },

              onDelete: (id) {
                context.read<FormCubit>().removeField(id);

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Field deleted"),
                    backgroundColor: Colors.red,
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
