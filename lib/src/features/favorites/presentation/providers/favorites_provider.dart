import 'package:flutter_riverpod/all.dart';
import 'package:statusesapp/src/features/favorites/domain/usecases/get_favorite_quotes.dart';
import 'package:statusesapp/src/features/quotes/data/models/quotes_model.dart';
import 'package:statusesapp/src/shared/usecases/usecase.dart';
import '../../../../shared/di/get_it.dart' as di;

final favoriteQuotesFutureProvider =
    FutureProvider.autoDispose<List<QuotesModel>>((ref) async {
  ref.maintainState = true;
  final GetFavoriteQuotes getFavoriteQuotes =
      ref.watch(favoriteQuotesUseCaseProvider);
  return await getFavoriteQuotes(NoParams());
});

final favoriteQuotesUseCaseProvider = Provider<GetFavoriteQuotes>((ref) {
  return di.getItInstance<GetFavoriteQuotes>();
});
