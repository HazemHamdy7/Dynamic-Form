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
        Expanded(
          child: ListView.builder(
            itemCount: options.length,
            itemBuilder: (context, index) {
              return TextField(
                controller: options[index],
                decoration: InputDecoration(
                  labelText: "Option ${index + 1}",
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => onRemove(index),
                  ),
                ),
              );
            },
          ),
        ),

        TextButton(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(Colors.black45),
            foregroundColor: WidgetStateProperty.all(Colors.white),
          ),
          onPressed: onAddOption,
          child: const Text("Add Option"),
        ),
      ],
    );
  }
}
