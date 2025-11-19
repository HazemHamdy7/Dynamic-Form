import 'package:dynamic_form/presentation/widget/field_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:dynamic_form/presentation/cubit/form_cubit.dart';
import 'package:dynamic_form/presentation/cubit/form_state.dart';

import 'package:dynamic_form/data/model/field_model.dart';
import 'package:dynamic_form/presentation/screens/add_field_dialog.dart';
import 'dynamic_form_screen.dart';

class FieldConfigScreen extends StatelessWidget {
  const FieldConfigScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<FormCubit>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Field Configuration"),
        actions: [
          BlocBuilder<FormCubit, DynamicFormState>(
            builder: (context, state) {
              return IconButton(
                icon: const Icon(Icons.remove_red_eye),
                onPressed: state.fields.isEmpty
                    ? null
                    : () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const DynamicFormScreen(),
                          ),
                        );
                      },
              );
            },
          ),
        ],
      ),

      body: FieldListView(),

      floatingActionButton: FloatingActionButton(
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
      ),
    );
  }
}
