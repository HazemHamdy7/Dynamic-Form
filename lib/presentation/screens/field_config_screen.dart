import 'package:dynamic_form/presentation/widgets/field_config/field_list_view.dart';
import 'package:dynamic_form/presentation/widgets/field_config/floating_action_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dynamic_form/presentation/cubit/form_cubit.dart';
import 'package:dynamic_form/presentation/cubit/form_state.dart';
import 'dynamic_form_screen.dart';

class FieldConfigScreen extends StatelessWidget {
  const FieldConfigScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<FormCubit>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Field Configuration"),
        actions: [
          BlocBuilder<FormCubit, DynamicFormState>(
            builder: (context, state) {
              return IconButton(
                icon: const Icon(Icons.remove_red_eye),
                onPressed: state.fields.isEmpty
                    ? null
                    : () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const DynamicFormScreen(),
                          ),
                        );
                      },
              );
            },
          ),
        ],
      ),

      body: FieldListView(),

      floatingActionButton: FloatingActionButtonWidget(cubit: cubit),
    );
  }
}
