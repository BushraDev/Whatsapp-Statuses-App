import 'package:meta/meta.dart';
import 'package:statusesapp/src/features/quotes/data/datasources/quotes_local_datasource.dart';
import 'package:statusesapp/src/features/quotes/data/datasources/quotes_remote_datasource.dart';
import 'package:statusesapp/src/features/quotes/domain/entities/quotes.dart';
import 'package:statusesapp/src/features/quotes/domain/repositories/quotes_repository.dart';
import 'package:statusesapp/src/shared/app/app_info.dart';
import 'package:statusesapp/src/shared/connectivity/connectivity_service.dart';
import 'package:statusesapp/src/shared/error/exceptions.dart';

class QuotesRepositoryImpl implements QuotesRepository {
  final QuotesRemoteDataSource remoteDataSource;
  final QuotesLocalDataSource localDataSource;
  final ConnectivityService connectivityService;

  QuotesRepositoryImpl({
    @required this.remoteDataSource,
    @required this.localDataSource,
    @required this.connectivityService,
  });

  @override
  Future<List<Quotes>> getQuotesByCategory(String category) async {
    print("this is getQuotesByCategory in repo");
    if (await connectivityService.isConnected) {
      final remoteQuotes = await remoteDataSource.getQuotesByCategory(category);
      localDataSource.cacheQuotes(remoteQuotes, category).then((value) async {
        await AppInfo.updateQuotesTableInitState();
      });
      return remoteQuotes;
    } else {
      print("this is localquotes cache try bloc");
      if (await AppInfo.isQuotesTableFirstInit()) {
        print("this is app first init");
        throw CacheException(message: "يرجى الإتصال بالإنترنت");
      } else {
        print("this is app not first init");
        final localQuotes = await localDataSource.getQuotesByCategory(category);
        return localQuotes;
      }
    }
  }
}
