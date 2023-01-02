import 'package:flutter_riverpod/all.dart';
import 'package:statusesapp/src/features/categories/data/models/categories_model.dart';
import 'package:statusesapp/src/features/categories/domain/usecases/get_categories.dart';
import 'package:statusesapp/src/shared/usecases/usecase.dart';
import '../../../../shared/di/get_it.dart' as di;

final categoriesFutureProvider =
    FutureProvider.autoDispose<List<CategoriesModel>>((ref) async {
  ref.maintainState = true;
  final GetCategories getCategories = ref.watch(categoriesProvider);
  return await getCategories(NoParams());
});

final categoriesProvider = Provider<GetCategories>((ref) {
  return di.getItInstance<GetCategories>();
});
