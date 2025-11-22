import 'package:dynamic_form/data/model/dropdown_field_model.dart';
import 'package:dynamic_form/data/model/radio_field_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dynamic_form/presentation/cubit/form_cubit.dart';
import 'package:dynamic_form/presentation/cubit/form_state.dart';
import 'package:dynamic_form/data/model/field_type.dart';

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
          //
          Row(
            children: const [
              Icon(Icons.auto_awesome, color: Colors.deepPurple, size: 22),
              SizedBox(width: 8),
              Text(
                "Form Preview",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // LIST VIEW INSIDE FIXED HEIGHT
          SizedBox(
            height: 200,
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

                return ListView.separated(
                  itemCount: state.fields.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final field = state.fields[index];
                    return _buildPreviewTile(field);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPreviewTile(FieldModel field) {
    IconData icon;

    switch (field.type) {
      case FieldType.text:
        icon = Icons.text_fields;
        break;
      case FieldType.dropdown:
        icon = Icons.arrow_drop_down_circle_outlined;
        break;
      case FieldType.radio:
        icon = Icons.radio_button_checked;
        break;
    }

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 3),
            blurRadius: 10,
            spreadRadius: 1,
            color: Colors.black12,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.deepPurple),
              const SizedBox(width: 8),
              Text(
                field.label,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),
          _buildFieldWidget(field),
        ],
      ),
    );
  }

  Widget _buildFieldWidget(FieldModel field) {
    switch (field.type) {
      case FieldType.text:
        return TextField(
          enabled: false,
          decoration: InputDecoration(
            hintText: "Enter ${field.label}...",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
        );

      case FieldType.dropdown:
        final fields = field as DropdownFieldModel;

        return SizedBox(
          height: (fields.options.length * 45).toDouble(),
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: fields.options.length,
            itemBuilder: (_, index) => ListTile(
              leading: const Icon(Icons.arrow_right, color: Colors.deepPurple),
              title: Text(fields.options[index]),
              dense: true,
              contentPadding: EdgeInsets.zero,
            ),
          ),
        );

      case FieldType.radio:
        final radio = field as RadioFieldModel;

        return SizedBox(
          height: (radio.options.length * 45).toDouble(),
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: radio.options.length,
            itemBuilder: (_, index) => ListTile(
              leading: const Icon(Icons.radio_button_unchecked),
              title: Text(radio.options[index]),
              dense: true,
              contentPadding: EdgeInsets.zero,
            ),
          ),
        );
    }
  }
}
