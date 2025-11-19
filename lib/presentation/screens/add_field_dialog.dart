import 'package:flutter/material.dart';
import 'package:dynamic_form/data/model/field_model.dart';
import 'package:dynamic_form/data/model/factory_model.dart';

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

    if (widget.editField != null) {
      selectedType = widget.editField!.type;

      if (widget.editField is DropdownFieldModel) {
        optionControllers = (widget.editField as DropdownFieldModel)
            .options
            .map((o) => TextEditingController(text: o))
            .toList();
      } else if (widget.editField is RadioFieldModel) {
        optionControllers = (widget.editField as RadioFieldModel)
            .options
            .map((o) => TextEditingController(text: o))
            .toList();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.editField == null ? "Add Field" : "Edit Field"),

      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // field name
            TextField(
              controller: labelController,
              decoration: const InputDecoration(
                labelText: "Field Name",
              ),
            ),
            const SizedBox(height: 12),

            // field type
            DropdownButtonFormField<FieldType>(
              value: selectedType,
              items: FieldType.values.map((t) {
                return DropdownMenuItem(
                  value: t,
                  child: Text(t.toString().split(".").last),
                );
              }).toList(),
              onChanged: (v) {
                setState(() => selectedType = v!);
              },
              decoration: const InputDecoration(labelText: "Field Type"),
            ),

            const SizedBox(height: 12),

            // options section
            if (selectedType != FieldType.text)
              Column(
                children: [
                  ...optionControllers.map(
                    (controller) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: TextField(
                        controller: controller,
                        decoration: InputDecoration(
                          labelText: "Option",
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () {
                              setState(() {
                                optionControllers.remove(controller);
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  ),

                  TextButton(
                    onPressed: () {
                      setState(() {
                        optionControllers.add(TextEditingController());
                      });
                    },
                    child: const Text("Add Option"),
                  )
                ],
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
            final name = labelController.text.trim();
            if (name.isEmpty) return;

            final options = optionControllers
                .map((c) => c.text.trim())
                .where((o) => o.isNotEmpty)
                .toList();

            FieldModel field =
                FieldFactory.create(selectedType, label: name, options: options);

            Navigator.pop(context, field);
          },
        ),
      ],
    );
  }
}
