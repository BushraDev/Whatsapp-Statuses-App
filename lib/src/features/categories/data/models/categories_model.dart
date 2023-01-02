import 'package:meta/meta.dart';
import 'package:statusesapp/src/features/categories/domain/entities/categories.dart';

class CategoriesModel extends Categories {
  CategoriesModel({
    @required String name,
  }) : super(name: name);

  factory CategoriesModel.fromJson(Map<String, dynamic> json) =>
      CategoriesModel(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}
