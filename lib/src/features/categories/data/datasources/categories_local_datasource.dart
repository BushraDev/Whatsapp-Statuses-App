import 'package:meta/meta.dart';
import 'package:sqflite/sqflite.dart';
import 'package:statusesapp/src/features/categories/data/models/categories_model.dart';
import 'package:statusesapp/src/shared/database/quote_base_helper.dart';
import 'package:statusesapp/src/shared/database/quote_db_schema/quote_db_schema.dart';
import 'package:statusesapp/src/shared/error/exceptions.dart';

abstract class CategoriesLocalDataSource {
  /// Gets the cached [CategoriesList] which was gotten the last time
  /// the user had an internet connection.
  ///
  /// Throws [CacheException] if no cached data is present.
  Future<List<CategoriesModel>> getCategories();

  Future<void> cacheCategories(List<CategoriesModel> categoriesToCache);

  Future<int> clearCachedCategories();
}

class CategoriesLocalDataSourceImpl implements CategoriesLocalDataSource {
  final QuoteBaseHelper quoteBaseHelper;

  CategoriesLocalDataSourceImpl({@required this.quoteBaseHelper});

  @override
  Future<List<CategoriesModel>> getCategories() async {
    Database dbClient = await quoteBaseHelper.db;
    print("This is getCategories method");
    List<Map<String, dynamic>> categoriesMapList = await dbClient.query(
      QuoteDbSchema.categoriesTable.name,
      columns: [
        QuoteDbSchema.categoriesTable.cols.name,
      ],
    );

    List<CategoriesModel> categoriesList = categoriesMapList
        .map((categoriesMap) => CategoriesModel.fromJson(categoriesMap))
        .toList();
    return categoriesList;
  }

  @override
  Future<void> cacheCategories(List<CategoriesModel> categoriesToCache) async {
    Database dbClient = await quoteBaseHelper.db;
    print("This is cacheCategories method");
    clearCachedCategories().then((value) => {
          categoriesToCache.forEach((category) {
            dbClient
                .insert(QuoteDbSchema.categoriesTable.name, category.toJson())
                .then((res) {
              print("${category.name} added successfully");
            });
          })
        });
  }

  @override
  Future<int> clearCachedCategories() async {
    Database dbClient = await quoteBaseHelper.db;
    print("This is clearCachedCategories method");
    return await dbClient.delete(
      QuoteDbSchema.categoriesTable.name,
    );
  }
}
