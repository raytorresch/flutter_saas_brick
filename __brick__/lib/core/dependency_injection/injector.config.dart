// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:{{projectName}}/core/dependency_injection/flavors.dart' as _i4;
import 'package:{{projectName}}/core/dependency_injection/modules.dart' as _i12;
import 'package:{{projectName}}/core/router/auth_notifier.dart' as _i11;
import 'package:{{projectName}}/core/utils/helpers/app_info_helper.dart' as _i8;
import 'package:{{projectName}}/core/utils/services/network_service.dart' as _i5;
import 'package:{{projectName}}/core/utils/services/preferences_service.dart' as _i9;
import 'package:{{projectName}}/core/utils/services/secure_storage_service.dart' as _i10;
import 'package:dio/dio.dart' as _i3;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i6;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:package_info_plus/package_info_plus.dart' as _i7;
import 'package:shared_preferences/shared_preferences.dart' as _i13;

const String _development = 'development';
const String _staging = 'staging';
const String _production = 'production';

extension GetItInjectableX on _i1.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i1.GetIt> init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final modules = _$Modules();

    // Flavors
    gh.lazySingleton<_i4.Flavor>(
      () => _i4.Development(),
      registerFor: {_development},
    );
    gh.lazySingleton<_i4.Flavor>(
      () => _i4.Staging(),
      registerFor: {_staging},
    );
    gh.lazySingleton<_i4.Flavor>(
      () => _i4.Production(),
      registerFor: {_production},
    );

    // Async pre-resolved singletons
    await gh.lazySingletonAsync<_i7.PackageInfo>(
      () => modules.packageInfo,
      preResolve: true,
    );
    await gh.lazySingletonAsync<_i13.SharedPreferences>(
      () => modules.prefs,
      preResolve: true,
    );

    // Sync singletons
    gh.lazySingleton<_i6.FlutterSecureStorage>(() => modules.secureStorage);
    gh.lazySingleton<_i3.Dio>(() => modules.dio);
    gh.lazySingleton<_i5.INetworkService>(() => _i5.NetworkServiceImpl());
    gh.lazySingleton<_i8.AppInfoHelper>(
      () => _i8.AppInfoHelper(gh<_i7.PackageInfo>()),
    );
    gh.lazySingleton<_i9.PreferencesService>(
      () => _i9.PreferencesService(gh<_i13.SharedPreferences>()),
    );
    gh.lazySingleton<_i10.SecureStorageService>(
      () => _i10.SecureStorageService(gh<_i6.FlutterSecureStorage>()),
    );
    gh.lazySingleton<_i11.AuthNotifier>(
      () => _i11.AuthNotifier(gh<_i10.SecureStorageService>()),
    );

    return this;
  }
}

class _$Modules extends _i12.Modules {}
