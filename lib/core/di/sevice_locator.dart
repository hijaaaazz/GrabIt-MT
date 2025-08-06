// service_locator.dart
import 'package:get_it/get_it.dart';
import 'package:grabit/core/network/network.dart';
import 'package:grabit/features/home/model/repos/home_repo.dart';
import 'package:grabit/features/home/model/services/local_service.dart';
import 'package:grabit/features/home/model/services/network_service.dart';

final getIt = GetIt.instance;

void setupLocator() {
  getIt.registerLazySingleton<HomeRepo>(() => HomeRepoImp());
  getIt.registerLazySingleton<NetworkService>(() => NetworkService());
  getIt.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl());
  getIt.registerLazySingleton<LocalStorage>(() => LocalStorage());

}
