import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dynamic_form/presentation/cubit/form_cubit.dart';
import 'package:dynamic_form/presentation/cubit/form_state.dart';

import 'preview_tile.dart';

class DynamicFormPreview extends StatelessWidget {
  const DynamicFormPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.deepPurple.shade50,
        borderRadius: BorderRadius.circular(18),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Form Preview",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
            ),
          ),

          const SizedBox(height: 16),

          SizedBox(
            height: 250,
            child: BlocBuilder<FormCubit, DynamicFormState>(
              builder: (context, state) {
                if (state.fields.isEmpty) {
                  return const Center(
                    child: Text(
                      "No preview available yet...",
                      style: TextStyle(color: Colors.grey),
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: state.fields.length,
                  itemBuilder: (context, index) {
                    return PreviewTile(field: state.fields[index]);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
