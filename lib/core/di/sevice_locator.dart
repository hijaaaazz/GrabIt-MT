// service_locator.dart
import 'package:get_it/get_it.dart';
import 'package:grabit/features/home/model/repos/home_repo.dart';

final getIt = GetIt.instance;

void setupLocator() {
  getIt.registerLazySingleton<HomeRepo>(() => HomeRepoImp());
}
