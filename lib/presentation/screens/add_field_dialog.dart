import 'package:dynamic_form/data/model/field_model.dart';
import 'package:dynamic_form/presentation/utils/add_field_helper.dart';
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
    final maxDialogWidth = MediaQuery.of(context).size.width * 0.6;

    return AlertDialog(
      title: Text(widget.editField == null ? "Add Field" : "Edit Field"),
      content: SizedBox(
        width: maxDialogWidth,
        height: 300,
        child: Column(
          children: [
            TextFormField(
              controller: labelController,
              decoration: const InputDecoration(
                labelText: "Label",
                border: OutlineInputBorder(),
              ),
            ),
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
              Expanded(
                child: OptionsListBuilder(
                  options: optionControllers,
                  onAddOption: addOption,
                  onRemove: removeOption,
                ),
              ),
          ],
        ),
      ),
      actions: [
        TextButton(
          style: TextButton.styleFrom(backgroundColor: Colors.red),
          child: const Text("Cancel", style: TextStyle(color: Colors.white)),
          onPressed: () => Navigator.pop(context),
        ),
        TextButton(
          style: TextButton.styleFrom(backgroundColor: Colors.green),
          child: const Text("Save", style: TextStyle(color: Colors.white)),
          onPressed: () {
            final field = AddFieldHelper.saveField(
              context: context,
              label: labelController.text,
              type: selectedType,
              optionControllers: optionControllers,
            );
            if (field != null) {
              Navigator.pop(context, field);
            }
          },
        ),
      ],
    );
  }
}
