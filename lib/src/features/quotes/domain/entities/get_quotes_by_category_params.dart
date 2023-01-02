import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class GetQuotesByCategoryParams extends Equatable {
  final String category;

  GetQuotesByCategoryParams({@required this.category});

  @override
  List<Object> get props => [category];
}
