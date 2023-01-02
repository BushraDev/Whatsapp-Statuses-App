import 'package:meta/meta.dart';
import 'package:sqflite/sqflite.dart';
import 'package:statusesapp/src/features/quotes/data/models/quotes_model.dart';
import 'package:statusesapp/src/shared/database/quote_base_helper.dart';
import 'package:statusesapp/src/shared/database/quote_db_schema/quote_db_schema.dart';

abstract class FavoriteQuotesLocalDataSource {
  Future<List<QuotesModel>> getFavoriteQuotes();

  Future<int> addQuoteToFavorites(QuotesModel quoteToAddToFavorites);

  Future<int> removeQuoteFromFavorites(QuotesModel quoteToRemoveFromFavorites);
}

class FavoriteQuotesLocalDataSourceImpl
    implements FavoriteQuotesLocalDataSource {
  final QuoteBaseHelper quoteBaseHelper;

  FavoriteQuotesLocalDataSourceImpl({@required this.quoteBaseHelper});

  @override
  Future<List<QuotesModel>> getFavoriteQuotes() async {
    Database dbClient = await quoteBaseHelper.db;
    print("This is getFavoriteQuotes method");
    List<Map<String, dynamic>> favoriteQuotesMapList =
        await dbClient.query(QuoteDbSchema.favoritesTable.name, columns: [
      QuoteDbSchema.favoritesTable.cols.quote,
      QuoteDbSchema.favoritesTable.cols.author,
    ]);

    List<QuotesModel> favoriteQuotesList = favoriteQuotesMapList
        .map((favoriteQuoteMap) => QuotesModel.fromJson(favoriteQuoteMap))
        .toList();
    return favoriteQuotesList;
  }

  @override
  Future<int> addQuoteToFavorites(QuotesModel quoteToAddToFavorites) async {
    Database dbClient = await quoteBaseHelper.db;
    print("This is addQuoteToFavorites method");
    return await dbClient.insert(QuoteDbSchema.favoritesTable.name, {
      "quote": quoteToAddToFavorites.quote,
      "author": quoteToAddToFavorites.author,
    });
  }

  @override
  Future<int> removeQuoteFromFavorites(
      QuotesModel quoteToRemoveFromFavorites) async {
    Database dbClient = await quoteBaseHelper.db;
    print("This is removeQuoteFromFavorites method");
    return await dbClient.delete(QuoteDbSchema.favoritesTable.name,
        where: '${QuoteDbSchema.favoritesTable.cols.quote} = ?',
        whereArgs: [quoteToRemoveFromFavorites.quote]);
  }
}
