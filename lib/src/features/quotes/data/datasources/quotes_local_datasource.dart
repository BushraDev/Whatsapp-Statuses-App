import 'package:meta/meta.dart';
import 'package:sqflite/sqflite.dart';

import 'package:statusesapp/src/features/quotes/data/models/quotes_model.dart';
import 'package:statusesapp/src/shared/database/quote_base_helper.dart';
import 'package:statusesapp/src/shared/database/quote_db_schema/quote_db_schema.dart';
import 'package:statusesapp/src/shared/error/exceptions.dart';

abstract class QuotesLocalDataSource {
  /// Gets the cached [QuotesList] which was gotten the last time
  /// the user had an internet connection.
  ///
  /// Throws [CacheException] if no cached data is present.
  Future<List<QuotesModel>> getQuotesByCategory(String category);

  Future<void> cacheQuotes(List<QuotesModel> quotesToCache, String category);

  Future<int> clearCachedQuotes(String category);
}

class QuotesLocalDataSourceImpl implements QuotesLocalDataSource {
  final QuoteBaseHelper quoteBaseHelper;

  QuotesLocalDataSourceImpl({@required this.quoteBaseHelper});

  @override
  Future<List<QuotesModel>> getQuotesByCategory(String category) async {
    Database dbClient = await quoteBaseHelper.db;
    print("This is getQuotesByCategory method");
    List<Map<String, dynamic>> quotesMapList =
        await dbClient.query(QuoteDbSchema.quoteTable.name,
            columns: [
              QuoteDbSchema.quoteTable.cols.quote,
              QuoteDbSchema.quoteTable.cols.author,
            ],
            where: '${QuoteDbSchema.quoteTable.cols.category} = ?',
            whereArgs: [category]);

    List<QuotesModel> quotesList = quotesMapList
        .map((quoteMap) => QuotesModel.fromJson(quoteMap))
        .toList();
    return quotesList;
  }

  @override
  Future<void> cacheQuotes(
      List<QuotesModel> quotesToCache, String category) async {
    Database dbClient = await quoteBaseHelper.db;
    print("This is cacheQuotes method");
    clearCachedQuotes(category).then((value) => {
          quotesToCache.forEach((quote) {
            dbClient.insert(QuoteDbSchema.quoteTable.name, {
              "quote": quote.quote,
              "author": quote.author,
              "category": category,
            }).then((res) {
              print("${quote.category} added successfully");
            });
          })
        });
  }

  @override
  Future<int> clearCachedQuotes(String category) async {
    Database dbClient = await quoteBaseHelper.db;
    print("This is clearCachedQuotes method");
    print(category);
    return await dbClient.delete(QuoteDbSchema.quoteTable.name,
        where: '${QuoteDbSchema.quoteTable.cols.category} = ?',
        whereArgs: [category]);
  }
}
