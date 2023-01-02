import 'package:meta/meta.dart';
import 'package:statusesapp/src/features/quotes/domain/entities/quotes.dart';

class QuotesModel extends Quotes {
  QuotesModel({
    @required String quote,
    @required String author,
    @required String category,
  }) : super(quote: quote, author: author, category: category);

  factory QuotesModel.fromJson(Map<String, dynamic> json) => QuotesModel(
        quote: json["quote"],
        author: json["author"],
        category: json["category"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "quote": quote,
        "author": author,
        "category": category,
      };
}
