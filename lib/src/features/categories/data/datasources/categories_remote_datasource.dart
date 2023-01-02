import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:statusesapp/src/features/categories/data/models/categories_model.dart';
import 'package:statusesapp/src/shared/error/exceptions.dart';

abstract class CategoriesRemoteDataSource {
  /// Calls the https://api.paperquotes.com/apiv1/tags/ endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<List<CategoriesModel>> getCategories();
}

class CategoriesRemoteDataSourceImpl implements CategoriesRemoteDataSource {
  final Dio dio;

  CategoriesRemoteDataSourceImpl({@required this.dio});

  @override
  Future<List<CategoriesModel>> getCategories() =>
      _getCategoriesFromUrl('https://api.paperquotes.com/apiv1/tags/');

  Future<List<CategoriesModel>> _getCategoriesFromUrl(String url) async {
    print("this is _getCategoriesFromUrl method");
    try {
      final response = await dio.get(
        url,
        options: Options(headers: {
          'Authorization': 'Token ac7ffa3fd98ea7a52dc9d54d9b7e652a49bdd23e',
        }),
      );
      print(response);
      if (response.data['results'] != null) {
        List<CategoriesModel> categoriesList = new List<CategoriesModel>();
        response.data['results'].forEach((categoryData) {
          categoriesList.add(CategoriesModel.fromJson(categoryData));
        });
        return categoriesList;
      }
    } on DioError catch (dioError) {
      print("this is catch of dio error $DioError");
      print("this is error message : ${dioError.message.toString()}");
      throw ServerException.fromDioError(dioError);
      //return error.message.toString();
    }
  }
}
