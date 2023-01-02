import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Categories extends Equatable {
  String name;

  Categories({
    @required this.name,
  });

  @override
  List<Object> get props => [name];
}
