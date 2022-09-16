import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:sembast/sembast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/local/datasources/post/post_datasource.dart';
import '../../data/network/apis/posts/post_api.dart';
import '../../data/network/dio_client.dart';
import '../../data/repository.dart';
import '../../data/sharedpref/shared_preference_helper.dart';
import '../../stores/employee_store.dart';
import '../module/local_module.dart';
import '../module/network_module.dart';

final getIt = GetIt.instance;

Future<void> setupLocator() async {
  getIt.registerSingletonAsync<Database>(() => LocalModule.provideDatabase());
  getIt.registerSingletonAsync<SharedPreferences>(
      () => LocalModule.provideSharedPreferences());

  getIt.registerSingleton(
      SharedPreferenceHelper(await getIt.getAsync<SharedPreferences>()));
  getIt.registerSingleton<Dio>(
      NetworkModule.provideDio(getIt<SharedPreferenceHelper>()));
  getIt.registerSingleton(DioClient(getIt<Dio>()));

  getIt.registerSingleton(PostApi(getIt<DioClient>()));
  getIt.registerSingleton(LocalDataSource(await getIt.getAsync<Database>()));

  getIt.registerSingleton(Repository(
    getIt<PostApi>(),
    getIt<SharedPreferenceHelper>(),
    getIt<LocalDataSource>(),
  ));

  getIt.registerSingleton(EmployeeStore(getIt<Repository>()));
}
