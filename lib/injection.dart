import 'package:get_it/get_it.dart';
import 'package:e3dad_5odam/data/repositories/excel_repository.dart';
import 'package:e3dad_5odam/presentation/cubit/student_results_cubit.dart';

final getIt = GetIt.instance;

void setupLocator() {
  getIt.registerLazySingleton(() => ExcelRepository());
  getIt.registerFactory(() => StudentResultsCubit(getIt()));
}
