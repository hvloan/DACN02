class AppRepositories {
  static const localhost = "hecommercestore.000webhostapp.com";
  static String mainUrl = "http://$localhost/Api";
  static String mainImageUrl = "http://$localhost/";

  static final loginUrl = "$mainUrl/auth/login.php";
  static final registerUrl = "$mainUrl/auth/create.php";
  static final getDetailsUserUrl = "$mainUrl/auth/read.php";
  static final updateUser = "$mainUrl/auth/update.php";

  static final getProductsUrl = "$mainUrl/products/read.php";

  static final getCategoriesUrl = "$mainUrl/categories/read.php";

  static final getProductTypesUrl = "$mainUrl/product_types/read.php";

  static final linkImageUrl = "$mainImageUrl/public/";

  static final linkImageProductTypeUrl = "$mainImageUrl/public/img/company/";

  static final paymentUrl = "$mainUrl/payments/create.php";

  static final getAllHistoriesUrl = "$mainUrl/histories/read.php";
}
