import 'package:dynamic_form/data/factory/factory_model.dart';
import 'package:dynamic_form/data/model/dropdown_field_model.dart';
import 'package:dynamic_form/data/model/field_type.dart';
import 'package:dynamic_form/data/model/radio_field_model.dart';
import 'package:dynamic_form/presentation/widgets/dialog/field_name_input.dart';
import 'package:dynamic_form/presentation/widgets/dialog/field_type_selector.dart';
import 'package:dynamic_form/presentation/widgets/dialog/options_list_builder.dart';
import 'package:flutter/material.dart';

class AddFieldDialog extends StatefulWidget {
  final FieldModel? editField;
  const AddFieldDialog({super.key, this.editField});

  @override
  State<AddFieldDialog> createState() => _AddFieldDialogState();
}

class _AddFieldDialogState extends State<AddFieldDialog> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController labelController;
  FieldType selectedType = FieldType.text;
  List<TextEditingController> optionControllers = [];

  @override
  void initState() {
    super.initState();

    labelController = TextEditingController(
      text: widget.editField?.label ?? "",
    );

    selectedType = widget.editField?.type ?? FieldType.text;

    if (widget.editField is DropdownFieldModel) {
      optionControllers = (widget.editField as DropdownFieldModel).options
          .map((o) => TextEditingController(text: o))
          .toList();
    } else if (widget.editField is RadioFieldModel) {
      optionControllers = (widget.editField as RadioFieldModel).options
          .map((o) => TextEditingController(text: o))
          .toList();
    }
  }

  @override
  void dispose() {
    labelController.dispose();
    for (final c in optionControllers) {
      c.dispose();
    }
    super.dispose();
  }

  void addOption() {
    setState(() {
      optionControllers.add(TextEditingController());
    });
  }

  void removeOption(int i) {
    setState(() {
      optionControllers[i].dispose();
      optionControllers.removeAt(i);
    });
  }

  @override
  Widget build(BuildContext context) {
    final maxDialogWidth = MediaQuery.of(context).size.width * 0.9;

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),

      title: Text(widget.editField == null ? "Add Field" : "Edit Field"),
      content: SizedBox(
        width: maxDialogWidth,
        height: 300,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // TextField
                FieldNameInput(labelController: labelController),

                const SizedBox(height: 12),

                FieldTypeSelector(
                  value: selectedType,
                  onChanged: (value) {
                    setState(() {
                      selectedType = value ?? FieldType.text;

                      if (selectedType == FieldType.text) {
                        for (final c in optionControllers) {
                          c.dispose();
                        }
                        optionControllers = [];
                      }
                    });
                  },
                ),

                const SizedBox(height: 12),

                if (selectedType != FieldType.text)
                  SizedBox(
                    height: 150,
                    child: OptionsListBuilder(
                      options: optionControllers,
                      onAddOption: addOption,
                      onRemove: removeOption,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),

      actions: [
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(Colors.red),
          ),
          child: const Text("Cancel", style: TextStyle(color: Colors.white)),
          onPressed: () => Navigator.pop(context),
        ),

        ElevatedButton(onPressed: _validateAndSave, child: const Text("Save")),
      ],
    );
  }

  void _validateAndSave() {
    if (!_formKey.currentState!.validate()) return;

    // validation for options
    if (selectedType != FieldType.text) {
      final validOptions = optionControllers
          .map((c) => c.text.trim())
          .where((o) => o.isNotEmpty)
          .toList();
      if (validOptions.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Please add at least one option"),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      final field = FieldFactory.create(
        selectedType,
        label: labelController.text.trim(),
        options: validOptions,
        id: widget.editField?.id,
      );

      Navigator.pop(context, field);
      return;
    }

    final field = FieldFactory.create(
      selectedType,
      label: labelController.text.trim(),
      options: [],
      id: widget.editField?.id,
    );

    Navigator.pop(context, field);
  }
}
