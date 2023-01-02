import 'package:statusesapp/src/features/quotes/domain/entities/get_quotes_by_category_params.dart';
import 'package:statusesapp/src/features/quotes/domain/entities/quotes.dart';
import 'package:statusesapp/src/features/quotes/domain/repositories/quotes_repository.dart';
import 'package:statusesapp/src/shared/usecases/usecase.dart';

class GetQuotesByCategory
    implements UseCase<List<Quotes>, GetQuotesByCategoryParams> {
  final QuotesRepository repository;

  GetQuotesByCategory(this.repository);

  @override
  Future<List<Quotes>> call(GetQuotesByCategoryParams params) async {
    return await repository.getQuotesByCategory(params.category);
  }
}
