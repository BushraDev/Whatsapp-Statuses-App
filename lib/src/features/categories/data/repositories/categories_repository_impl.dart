import 'package:meta/meta.dart';
import 'package:statusesapp/src/features/categories/data/datasources/categories_local_datasource.dart';
import 'package:statusesapp/src/features/categories/data/datasources/categories_remote_datasource.dart';
import 'package:statusesapp/src/features/categories/domain/entities/categories.dart';
import 'package:statusesapp/src/features/categories/domain/repositories/categories_repository.dart';
import 'package:statusesapp/src/shared/app/app_info.dart';
import 'package:statusesapp/src/shared/connectivity/connectivity_service.dart';
import 'package:statusesapp/src/shared/error/exceptions.dart';

class CategoriesRepositoryImpl implements CategoriesRepository {
  final CategoriesRemoteDataSource remoteDataSource;
  final CategoriesLocalDataSource localDataSource;
  final ConnectivityService connectivityService;

  CategoriesRepositoryImpl({
    @required this.remoteDataSource,
    @required this.localDataSource,
    @required this.connectivityService,
  });

  @override
  Future<List<Categories>> getCategories() async {
    print("this is getCategories in repo");
    if (await connectivityService.isConnected) {
      print("is connected ${await connectivityService.isConnected}");
      final remoteCategories = await remoteDataSource.getCategories();
      localDataSource.cacheCategories(remoteCategories).then((value) async {
        await AppInfo.updateCategoriesTableInitState();
      });
      return remoteCategories;
    } else {
      print("this is local categories cache try bloc");
      if (await AppInfo.isCategoriesTableFirstInit()) {
        print("this is app first init");
        throw CacheException(message: "يرجى الإتصال بالإنترنت");
      } else {
        print("this is app not first init");
        final localCategories = await localDataSource.getCategories();
        return localCategories;
      }
    }
  }
}
