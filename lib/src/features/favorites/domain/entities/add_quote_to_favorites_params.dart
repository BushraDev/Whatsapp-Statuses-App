import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:statusesapp/src/features/quotes/domain/entities/quotes.dart';

class AddQuoteToFavoritesParams extends Equatable {
  final Quotes quote;

  AddQuoteToFavoritesParams({@required this.quote});

  @override
  List<Object> get props => [quote];
}
