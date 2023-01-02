import 'package:statusesapp/src/features/categories/domain/entities/categories.dart';

abstract class CategoriesRepository {
  Future<List<Categories>> getCategories();
}
