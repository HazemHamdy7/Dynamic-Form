import 'package:dynamic_form/data/repository/form_repository.dart';
import 'package:dynamic_form/presentation/cubit/form_cubit.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void initServiceLocator() {
  // Repository

  getIt.registerLazySingleton<FormRepository>(() => FormRepository());

  // Cubit
  getIt.registerFactory<FormCubit>(() => FormCubit(getIt<FormRepository>()));
}
