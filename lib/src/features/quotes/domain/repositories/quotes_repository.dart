import 'package:statusesapp/src/features/quotes/domain/entities/quotes.dart';

abstract class QuotesRepository {
  Future<List<Quotes>> getQuotesByCategory(String category);
}
