import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Quotes extends Equatable {
  String quote;
  String author;
  String category;

  Quotes({
    @required this.quote,
    @required this.author,
    @required this.category,
  });

  @override
  List<Object> get props => [quote, author, category];
}
