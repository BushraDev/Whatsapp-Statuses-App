import 'package:flutter_riverpod/all.dart';
import 'package:statusesapp/src/features/quotes/domain/entities/get_quotes_by_category_params.dart';
import 'package:statusesapp/src/features/quotes/domain/entities/quotes.dart';
import 'package:statusesapp/src/features/quotes/domain/usecases/get_quotes_by_category.dart';
import '../../../../shared/di/get_it.dart' as di;

final quotesByCategoryFutureProvider = FutureProvider.autoDispose
    .family<List<Quotes>, String>((ref, category) async {
  ref.maintainState = true;
  final GetQuotesByCategory getQuotesByCategory =
      ref.watch(quotesByCategoryUseCaseProvider);
  return await getQuotesByCategory(
      GetQuotesByCategoryParams(category: category));
});

final quotesByCategoryUseCaseProvider = Provider<GetQuotesByCategory>((ref) {
  return di.getItInstance<GetQuotesByCategory>();
});
