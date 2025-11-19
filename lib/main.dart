import 'package:dynamic_form/presentation/cubit/form_cubit.dart';
import 'package:dynamic_form/presentation/screens/field_config_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FormCubit(),
      child: MaterialApp(
        title: 'Dynamic Form Builder',
        theme: ThemeData(primarySwatch: Colors.deepPurple, useMaterial3: true),
        debugShowCheckedModeBanner: false,
        home: const FieldConfigScreen(),
      ),
    );
  }
}
