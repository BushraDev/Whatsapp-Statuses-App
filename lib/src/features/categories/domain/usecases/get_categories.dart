import 'package:statusesapp/src/features/categories/domain/entities/categories.dart';
import 'package:statusesapp/src/features/categories/domain/repositories/categories_repository.dart';
import 'package:statusesapp/src/shared/usecases/usecase.dart';

class GetCategories implements UseCase<List<Categories>, NoParams> {
  final CategoriesRepository repository;

  GetCategories(this.repository);

  @override
  Future<List<Categories>> call(NoParams noParams) async {
    return await repository.getCategories();
  }
}
