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

        return ReorderableListView.builder(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.only(bottom: 100),

          itemCount: state.fields.length,
          onReorder: cubit.reorderFields,
          itemBuilder: (context, index) {
            final field = state.fields[index];

            return Container(
              key: ValueKey(field.id),
              child: FieldItemTile(
                field: field,

                onEdit: (oldField) async {
                  final updatedField = await showDialog<FieldModel?>(
                    context: context,
                    builder: (_) => AddFieldDialog(editField: oldField),
                  );
                  if (updatedField != null) {
                    cubit.updateField(updatedField);
                  }
                },

                onDelete: (id) {
                  cubit.removeField(id);
                },
              ),
            );
          },
        );
      },
    );
  }
}
