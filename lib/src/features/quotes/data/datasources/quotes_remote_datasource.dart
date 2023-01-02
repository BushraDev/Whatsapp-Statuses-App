import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:statusesapp/src/features/quotes/data/models/quotes_model.dart';
import 'package:statusesapp/src/shared/error/exceptions.dart';

abstract class QuotesRemoteDataSource {
  /// Calls the https://api.paperquotes.com/apiv1/quotes/?tags={tag} endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<List<QuotesModel>> getQuotesByCategory(String category);
}

class QuotesRemoteDataSourceImpl implements QuotesRemoteDataSource {
  final Dio dio;

  QuotesRemoteDataSourceImpl({@required this.dio});

  @override
  Future<List<QuotesModel>> getQuotesByCategory(String category) =>
      _getQuotesFromUrl(
          'https://api.paperquotes.com/apiv1/quotes/?tags=$category');

  Future<List<QuotesModel>> _getQuotesFromUrl(String url) async {
    print("this is _getQuotesFromUrl");
    try {
      final response = await dio.get(
        url,
        options: Options(headers: {
          'Authorization': 'Token ac7ffa3fd98ea7a52dc9d54d9b7e652a49bdd23e',
        }),
      );
      print(response);
      if (response.data['results'] != null) {
        List<QuotesModel> quotesList = new List<QuotesModel>();
        response.data['results'].forEach((quoteData) {
          quotesList.add(QuotesModel.fromJson(quoteData));
        });
        return quotesList;
      }
    } on DioError catch (dioError) {
      print("this is catch of dio error $DioError");
      print("this is error message : ${dioError.message.toString()}");
      throw ServerException.fromDioError(dioError);
      //return error.message.toString();
    }
  }
}
