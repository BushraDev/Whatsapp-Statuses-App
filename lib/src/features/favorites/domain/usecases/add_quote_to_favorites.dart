import 'package:statusesapp/src/features/favorites/domain/entities/add_quote_to_favorites_params.dart';
import 'package:statusesapp/src/features/favorites/domain/repositories/quotes_repository.dart';
import 'package:statusesapp/src/shared/usecases/usecase.dart';

class AddQuoteToFavorites implements UseCase<void, AddQuoteToFavoritesParams> {
  final FavoriteQuotesRepository repository;

  AddQuoteToFavorites(this.repository);

  @override
  Future<int> call(AddQuoteToFavoritesParams params) async {
    return await repository.addQuoteToFavorites(params.quote);
  }
}
