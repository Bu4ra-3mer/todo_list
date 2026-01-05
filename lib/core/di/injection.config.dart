// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:todo_list/features/auth/data/auth_repositoey_impl/auth_repository_impl.dart'
    as _i136;
import 'package:todo_list/features/auth/data/data_source/auth_remote_data_source.dart'
    as _i369;
import 'package:todo_list/features/auth/domain/repository/auth_repo.dart'
    as _i1039;
import 'package:todo_list/features/auth/domain/usecases/get_currenuser_usecase.dart'
    as _i104;
import 'package:todo_list/features/auth/domain/usecases/sign_in_anonymous_usecase.dart'
    as _i1060;
import 'package:todo_list/features/auth/domain/usecases/sign_in_usecase.dart'
    as _i473;
import 'package:todo_list/features/auth/domain/usecases/sign_out_usecase.dart'
    as _i359;
import 'package:todo_list/features/auth/domain/usecases/sign_up_usecase.dart'
    as _i450;
import 'package:todo_list/features/auth/presentation/cubit/auth_cubit_cubit.dart'
    as _i250;
import 'package:todo_list/features/todo_list/data/datasource/string_item_remote_datasource.dart'
    as _i756;
import 'package:todo_list/features/todo_list/data/repository_impl/string_item_repo_impl.dart'
    as _i496;
import 'package:todo_list/features/todo_list/domain/repository/string_item_repo.dart'
    as _i351;
import 'package:todo_list/features/todo_list/domain/usecases/add_string_item_usecase.dart'
    as _i452;
import 'package:todo_list/features/todo_list/domain/usecases/get_strings_usecase.dart'
    as _i533;
import 'package:todo_list/features/todo_list/presentation/cubit/cubit_cubit.dart'
    as _i1035;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i756.StringItemRemoteDatasource>(
        () => _i756.StringItemRemoteDatasourceImpl());
    gh.factory<_i369.AuthRemoteDataSource>(
        () => _i369.AuthRemoteDataSourceImpl());
    gh.factory<_i1039.AuthRepo>(() => _i136.AuthRepositoryImpl(
        remoteDataSource: gh<_i369.AuthRemoteDataSource>()));
    gh.factory<_i104.GetCurrenuserUsecase>(
        () => _i104.GetCurrenuserUsecase(repository: gh<_i1039.AuthRepo>()));
    gh.factory<_i473.SignInUsecase>(
        () => _i473.SignInUsecase(repository: gh<_i1039.AuthRepo>()));
    gh.factory<_i359.SignOutUsecase>(
        () => _i359.SignOutUsecase(repository: gh<_i1039.AuthRepo>()));
    gh.factory<_i450.SignUpUsecase>(
        () => _i450.SignUpUsecase(repository: gh<_i1039.AuthRepo>()));
    gh.factory<_i250.AuthCubitCubit>(
        () => _i250.AuthCubitCubit(repository: gh<_i1039.AuthRepo>()));
    gh.factory<_i1060.SignInAnonymousUsecase>(
        () => _i1060.SignInAnonymousUsecase(gh<_i1039.AuthRepo>()));
    gh.factory<_i351.StringItemRepo>(() => _i496.StringItemRepoImpl(
        remote: gh<_i756.StringItemRemoteDatasource>()));
    gh.factory<_i452.AddStringItemUsecase>(() =>
        _i452.AddStringItemUsecase(repository: gh<_i351.StringItemRepo>()));
    gh.factory<_i533.GetStringsUsecase>(
        () => _i533.GetStringsUsecase(repository: gh<_i351.StringItemRepo>()));
    gh.factory<_i1035.StringItemCubit>(
        () => _i1035.StringItemCubit(repository: gh<_i351.StringItemRepo>()));
    return this;
  }
}
