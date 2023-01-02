import 'tables/categories_table.dart';
import 'tables/favorites_table.dart';
import 'tables/quotes_table.dart';

class QuoteDbSchema {
  static final QuotesTable quoteTable = QuotesTable();
  static final CategoriesTable categoriesTable = CategoriesTable();
  static final FavoritesTable favoritesTable = FavoritesTable();
}
