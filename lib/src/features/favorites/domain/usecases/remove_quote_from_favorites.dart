import 'package:statusesapp/src/features/favorites/domain/entities/remove_quote_from_favorites_params.dart';
import 'package:statusesapp/src/features/favorites/domain/repositories/quotes_repository.dart';
import 'package:statusesapp/src/shared/usecases/usecase.dart';

class RemoveQuoteFromFavorites
    implements UseCase<void, RemoveQuoteFromFavoritesParams> {
  final FavoriteQuotesRepository repository;

  RemoveQuoteFromFavorites(this.repository);

  @override
  Future<int> call(RemoveQuoteFromFavoritesParams params) async {
    return await repository.removeQuoteFromFavorites(params.quote);
  }
}
