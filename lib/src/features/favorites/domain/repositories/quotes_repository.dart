import 'package:statusesapp/src/features/quotes/domain/entities/quotes.dart';

abstract class FavoriteQuotesRepository {
  Future<List<Quotes>> getFavoriteQuotes();
  Future<int> addQuoteToFavorites(Quotes quoteToAddToFavorites);
  Future<int> removeQuoteFromFavorites(Quotes quoteToRemoveFromFavorites);
}
