import 'package:dartz/dartz.dart';
import 'package:grabit/core/di/sevice_locator.dart';
import 'package:grabit/core/network/network.dart';
import 'package:grabit/features/home/model/section_model.dart';
import 'package:grabit/features/home/model/services/local_service.dart';
import 'package:grabit/features/home/model/services/network_service.dart';

abstract class HomeRepo {
  Future<Either<String, List<SectionModel>>> getHomeSections();
}

class HomeRepoImp implements HomeRepo {
  final NetworkService remote = getIt<NetworkService>();
  final NetworkInfo networkInfo = getIt<NetworkInfo>();
  final LocalStorage local = getIt<LocalStorage>();

  @override
  Future<Either<String, List<SectionModel>>> getHomeSections() async {
    try {
      if (await networkInfo.isConnected) {
        final result = await remote.getHomeSections();
        return result.fold(
          (error) => Left(error),
          (sections) async {
            await local.saveHomeSections(sections);
            return Right(sections);
          },
        );
      } else {
        return await local.getHomeSections();
      }
    } catch (e) {
      return Left("Something went wrong: ${e.toString()}");
    }
  }
}