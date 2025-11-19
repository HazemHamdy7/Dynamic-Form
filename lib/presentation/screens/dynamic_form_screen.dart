import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dynamic_form/presentation/cubit/form_cubit.dart';
import 'package:dynamic_form/presentation/cubit/form_state.dart';
import 'package:dynamic_form/data/model/field_model.dart';

class DynamicFormScreen extends StatelessWidget {
  const DynamicFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Dynamic Form")),

      body: BlocBuilder<FormCubit, DynamicFormState>(
        builder: (context, state) {
          final fields = state.fields;

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              ...fields.map((f) {
                if (f is TextFieldModel) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: f.label,
                        border: const OutlineInputBorder(),
                      ),
                    ),
                  );
                }

                if (f is DropdownFieldModel) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: DropdownButtonFormField(
                      items: f.options
                          .map(
                            (o) => DropdownMenuItem(value: o, child: Text(o)),
                          )
                          .toList(),
                      onChanged: (v) {},
                      decoration: InputDecoration(
                        labelText: f.label,
                        border: const OutlineInputBorder(),
                      ),
                    ),
                  );
                }

                if (f is RadioFieldModel) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          f.label,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        ...f.options.map(
                          (o) => Row(
                            children: [
                              Radio(
                                value: o,
                                groupValue: null,
                                onChanged: (v) {},
                              ),
                              Text(o),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return const SizedBox.shrink();
              }),
            ],
          );
        },
      ),
    );
  }
}
