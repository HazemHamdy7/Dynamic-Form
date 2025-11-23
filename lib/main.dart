import 'package:dynamic_form/core/di/service_locator.dart';
import 'package:dynamic_form/core/shared/app_constant.dart';
import 'package:dynamic_form/core/theme/app_theme.dart';
import 'package:dynamic_form/data/repository/form_repository.dart';
import 'package:dynamic_form/presentation/cubit/form_cubit.dart';
import 'package:dynamic_form/presentation/screens/field_config_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await Hive.openBox(AppConstant.fieldsBox);
  initServiceLocator();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final repo = FormRepository();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<FormCubit>(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        home: const FieldConfigScreen(),
      ),
    );
  }
}
