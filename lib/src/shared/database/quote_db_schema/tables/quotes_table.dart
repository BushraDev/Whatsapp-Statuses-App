class QuotesTable {
  String get name => "quotes";
  Cols get cols => Cols();
}

class Cols {
  String get quote => "quote";
  String get author => "author";
  String get category => "category";
}
