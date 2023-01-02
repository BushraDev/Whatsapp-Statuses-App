import 'package:statusesapp/src/features/favorites/domain/repositories/quotes_repository.dart';
import 'package:statusesapp/src/features/quotes/domain/entities/quotes.dart';
import 'package:statusesapp/src/shared/usecases/usecase.dart';

class GetFavoriteQuotes implements UseCase<List<Quotes>, NoParams> {
  final FavoriteQuotesRepository repository;

  GetFavoriteQuotes(this.repository);

  @override
  Future<List<Quotes>> call(NoParams params) async {
    return await repository.getFavoriteQuotes();
  }
}
