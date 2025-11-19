import 'package:dynamic_form/helper/add_field_helper.dart';
import 'package:flutter/material.dart';
import 'package:dynamic_form/data/model/field_model.dart';
import 'package:dynamic_form/presentation/widget/dialog/field_name_input.dart';
import 'package:dynamic_form/presentation/widget/dialog/field_type_selector.dart';
import 'package:dynamic_form/presentation/widget/dialog/options_list_builder.dart';

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
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.editField == null ? "Add Field" : "Edit Field"),

      content: SingleChildScrollView(
        child: Column(
          children: [
            FieldNameInput(controller: labelController),
            const SizedBox(height: 12),

            FieldTypeSelector(
              value: selectedType,
              onChanged: (v) => setState(() => selectedType = v!),
            ),
            const SizedBox(height: 12),

            if (selectedType != FieldType.text)
              OptionsListBuilder(
                options: optionControllers,
                onAddOption: () {
                  AddFieldHelper.addOption(
                    context: context,
                    optionControllers: optionControllers,
                    onUpdate: () => setState(() {}),
                  );
                },
                onRemove: (i) => setState(() {
                  optionControllers.removeAt(i);
                }),
              ),
          ],
        ),
      ),

      actions: [
        TextButton(
          child: const Text("Cancel"),
          onPressed: () => Navigator.pop(context),
        ),

        ElevatedButton(
          child: const Text("Save"),
          onPressed: () {
            final model = AddFieldHelper.saveField(
              context: context,
              label: labelController.text,
              type: selectedType,
              optionControllers: optionControllers,
            );

            if (model != null) Navigator.pop(context, model);
          },
        ),
      ],
    );
  }
}
