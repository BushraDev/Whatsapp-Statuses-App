class Images {
  static final String logo = 'logo.png'.imagePath;
  static final String category = 'sad.jpg'.imagePath;
}

extension Assets on String {
  static String get assetPath => 'assets/';
  String get imagePath => assetPath + 'images/' + this;
}
