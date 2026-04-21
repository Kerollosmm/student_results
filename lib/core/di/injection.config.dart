// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:e3dad_5odam/features/results/data/datasources/excel_datasource.dart'
    as _i51;
import 'package:e3dad_5odam/features/results/data/repositories/results_repository_impl.dart'
    as _i467;
import 'package:e3dad_5odam/features/results/domain/repositories/results_repository.dart'
    as _i314;
import 'package:e3dad_5odam/features/results/presentation/cubit/login_cubit.dart'
    as _i16;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.factory<_i51.ExcelDatasource>(() => _i51.ExcelDatasource());
    gh.factory<_i314.ResultsRepository>(
      () => _i467.ResultsRepositoryImpl(gh<_i51.ExcelDatasource>()),
    );
    gh.factory<_i16.LoginCubit>(
      () => _i16.LoginCubit(gh<_i314.ResultsRepository>()),
    );
    return this;
  }
}
