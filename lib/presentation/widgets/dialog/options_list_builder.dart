import 'package:flutter/material.dart';

class OptionsListBuilder extends StatelessWidget {
  final List<TextEditingController> options;
  final VoidCallback onAddOption;
  final void Function(int index) onRemove;

  const OptionsListBuilder({
    super.key,
    required this.options,
    required this.onAddOption,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...List.generate(
          options.length,
          (index) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: TextField(
              controller: options[index],
              decoration: InputDecoration(
                labelText: "Option",
                suffixIcon: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => onRemove(index),
                ),
              ),
            ),
          ),
        ),

        TextButton(onPressed: onAddOption, child: const Text("Add Option")),
      ],
    );
  }
}
