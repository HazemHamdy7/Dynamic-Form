import 'package:dynamic_form/presentation/widgets/field_widgets/dropdown_field_item.dart';
import 'package:dynamic_form/presentation/widgets/field_widgets/radio_field_item.dart';
import 'package:dynamic_form/presentation/widgets/field_widgets/text_field_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dynamic_form/presentation/cubit/form_cubit.dart';
import 'package:dynamic_form/presentation/cubit/form_state.dart';
import 'package:dynamic_form/data/model/field_model.dart';

class DynamicFormScreen extends StatelessWidget {
  const DynamicFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(title: const Text("Dynamic Form")),
      body: BlocBuilder<FormCubit, DynamicFormState>(
        builder: (context, state) {
          final cubit = context.read<FormCubit>();
          final fields = state.fields;

          return Form(
            key: _formKey,
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: fields.length + 1,
              itemBuilder: (context, index) {
                if (index == fields.length) {
                  return ElevatedButton(
                    child: const Text("Submit"),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();

                        final answers = cubit.state.answers;

                        showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: const Text("Submitted"),
                            content: Text(answers.toString()),
                          ),
                        );
                      }
                    },
                  );
                }

                final field = fields[index];

                if (field is TextFieldModel) {
                  return TextFieldItem(field: field);
                } else if (field is DropdownFieldModel) {
                  return DropdownFieldItem(field: field);
                } else if (field is RadioFieldModel) {
                  return RadioFieldItem(field: field);
                }

                return const SizedBox.shrink();
              },
            ),
          );
        },
      ),
    );
  }
}
