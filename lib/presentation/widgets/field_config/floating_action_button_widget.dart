import 'package:dynamic_form/data/model/field_model.dart';
import 'package:dynamic_form/presentation/cubit/form_cubit.dart';
import 'package:dynamic_form/presentation/screens/add_field_dialog.dart';
import 'package:flutter/material.dart';

class FloatingActionButtonWidget extends StatelessWidget {
  const FloatingActionButtonWidget({
    super.key,
    required this.cubit,
  });

  final FormCubit cubit;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      tooltip: "Add Field",
      backgroundColor: Colors.deepPurple,
      foregroundColor: Colors.white,
      child: const Icon(Icons.add),
      onPressed: () async {
        final created = await showDialog<FieldModel?>(
          context: context,
          builder: (_) => const AddFieldDialog(),
        );
    
        if (created != null) {
          cubit.addField(created);
        }
      },
    );
  }
}
