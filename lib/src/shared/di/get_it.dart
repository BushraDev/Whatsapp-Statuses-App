import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:statusesapp/src/features/categories/data/datasources/categories_local_datasource.dart';
import 'package:statusesapp/src/features/categories/data/datasources/categories_remote_datasource.dart';
import 'package:statusesapp/src/features/categories/data/repositories/categories_repository_impl.dart';
import 'package:statusesapp/src/features/categories/domain/repositories/categories_repository.dart';
import 'package:statusesapp/src/features/categories/domain/usecases/get_categories.dart';
import 'package:statusesapp/src/features/favorites/data/datasources/favorite_quotes_local_datasource.dart';
import 'package:statusesapp/src/features/favorites/data/repositories/quotes_repository_impl.dart';
import 'package:statusesapp/src/features/favorites/domain/repositories/quotes_repository.dart';
import 'package:statusesapp/src/features/favorites/domain/usecases/add_quote_to_favorites.dart';
import 'package:statusesapp/src/features/favorites/domain/usecases/get_favorite_quotes.dart';
import 'package:statusesapp/src/features/favorites/domain/usecases/remove_quote_from_favorites.dart';
import 'package:statusesapp/src/features/quotes/data/datasources/quotes_local_datasource.dart';
import 'package:statusesapp/src/features/quotes/data/datasources/quotes_remote_datasource.dart';
import 'package:statusesapp/src/features/quotes/data/repositories/quotes_repository_impl.dart';
import 'package:statusesapp/src/features/quotes/domain/repositories/quotes_repository.dart';
import 'package:statusesapp/src/features/quotes/domain/usecases/get_quotes_by_category.dart';
import 'package:statusesapp/src/shared/connectivity/connectivity_service.dart';
import 'package:statusesapp/src/shared/database/quote_base_helper.dart';
import 'package:statusesapp/src/shared/layout/responsive.dart';

final getItInstance = GetIt.I;

Future<void> init() async {
  // Use cases
  getItInstance
      .registerLazySingleton(() => AddQuoteToFavorites(getItInstance()));
  getItInstance.registerLazySingleton(() => GetFavoriteQuotes(getItInstance()));
  getItInstance
      .registerLazySingleton(() => GetQuotesByCategory(getItInstance()));
  getItInstance
      .registerLazySingleton(() => RemoveQuoteFromFavorites(getItInstance()));
  getItInstance.registerLazySingleton(() => GetCategories(getItInstance()));

  // Repository
  getItInstance.registerLazySingleton<QuotesRepository>(
    () => QuotesRepositoryImpl(
      localDataSource: getItInstance(),
      connectivityService: getItInstance(),
      remoteDataSource: getItInstance(),
    ),
  );

  getItInstance.registerLazySingleton<FavoriteQuotesRepository>(
    () => FavoriteQuotesRepositoryImpl(
      localDataSource: getItInstance(),
      connectivityService: getItInstance(),
    ),
  );
  getItInstance.registerLazySingleton<CategoriesRepository>(
    () => CategoriesRepositoryImpl(
      localDataSource: getItInstance(),
      connectivityService: getItInstance(),
      remoteDataSource: getItInstance(),
    ),
  );

  // Data sources
  getItInstance.registerLazySingleton<QuotesLocalDataSource>(
    () => QuotesLocalDataSourceImpl(quoteBaseHelper: getItInstance()),
  );
  getItInstance.registerLazySingleton<QuotesRemoteDataSource>(
    () => QuotesRemoteDataSourceImpl(dio: getItInstance()),
  );
  getItInstance.registerLazySingleton<FavoriteQuotesLocalDataSource>(
    () => FavoriteQuotesLocalDataSourceImpl(quoteBaseHelper: getItInstance()),
  );
  getItInstance.registerLazySingleton<CategoriesRemoteDataSource>(
    () => CategoriesRemoteDataSourceImpl(dio: getItInstance()),
  );
  getItInstance.registerLazySingleton<CategoriesLocalDataSource>(
    () => CategoriesLocalDataSourceImpl(quoteBaseHelper: getItInstance()),
  );

  //! Shared
  getItInstance.registerLazySingleton<Responsive>(() => Responsive());
  getItInstance.registerLazySingleton<ConnectivityService>(
      () => ConnectivityServiceImpl());
  getItInstance.registerLazySingleton(() => QuoteBaseHelper());

  //! External
  getItInstance.registerLazySingleton(() => Dio());
}
