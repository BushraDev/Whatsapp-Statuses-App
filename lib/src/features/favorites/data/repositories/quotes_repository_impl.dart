import 'package:meta/meta.dart';
import 'package:statusesapp/src/features/favorites/data/datasources/favorite_quotes_local_datasource.dart';
import 'package:statusesapp/src/features/favorites/domain/repositories/quotes_repository.dart';
import 'package:statusesapp/src/features/quotes/data/models/quotes_model.dart';
import 'package:statusesapp/src/features/quotes/domain/entities/quotes.dart';
import 'package:statusesapp/src/shared/connectivity/connectivity_service.dart';

class FavoriteQuotesRepositoryImpl implements FavoriteQuotesRepository {
  final FavoriteQuotesLocalDataSource localDataSource;
  final ConnectivityService connectivityService;

  FavoriteQuotesRepositoryImpl({
    @required this.localDataSource,
    @required this.connectivityService,
  });

  @override
  Future<List<QuotesModel>> getFavoriteQuotes() async {
    return await localDataSource.getFavoriteQuotes();
  }

  @override
  Future<int> addQuoteToFavorites(Quotes quoteToAddToFavorites) async {
    return await localDataSource.addQuoteToFavorites(quoteToAddToFavorites);
  }

  @override
  Future<int> removeQuoteFromFavorites(
      Quotes quoteToRemoveFromFavorites) async {
    return await localDataSource
        .removeQuoteFromFavorites(quoteToRemoveFromFavorites);
  }
}
