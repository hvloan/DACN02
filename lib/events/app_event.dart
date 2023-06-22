import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:e_commerce_app/constants/tmp_cart.dart';
import 'package:e_commerce_app/models/cart_model.dart';
import 'package:e_commerce_app/models/category_model.dart';
import 'package:e_commerce_app/models/details_product_model.dart';
import 'package:e_commerce_app/models/history_model.dart';
import 'package:e_commerce_app/models/product_model.dart';
import 'package:e_commerce_app/models/product_type_model.dart';
import 'package:e_commerce_app/repositories/app_repositories.dart';
import 'package:e_commerce_app/screens/pages/check_out_complete_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Future<List<ProductModel>> fetchProductsByCategory(int categoryID) async {
  final dio = Dio();
  Map<String, dynamic> data = {'MaDM': categoryID};
  var products = <ProductModel>[];

  final response = await dio.get(
    AppRepositories.getProductsUrl,
    options: Options(
      contentType: 'application/json;charset=utf-8',
      responseType: ResponseType.plain,
    ),
    queryParameters: data,
  );
  if (response.statusCode == 200) {
    if (response.data != null) {
      var jsonResponses = jsonDecode(response.data);
      var jsonProducts = jsonResponses['dataProducts'];

      for (var product in jsonProducts) {
        products.add(ProductModel.fromJson(product));
      }
    }
  } else {
    products = [];
    if (kDebugMode) {
      print(response.data);
    }
  }
  return products;
}

Future<List<ProductModel>> fetchProductsByProductType(
    int categoryID, int productTypeID) async {
  final dio = Dio();
  Map<String, dynamic> data = {'MaDM': categoryID, 'MaLSP': productTypeID};
  var products = <ProductModel>[];

  final response = await dio.get(
    AppRepositories.getProductsUrl,
    options: Options(
      contentType: 'application/json;charset=utf-8',
      responseType: ResponseType.plain,
    ),
    queryParameters: data,
  );
  if (response.statusCode == 200) {
    if (response.data != null) {
      var jsonResponses = jsonDecode(response.data);
      var jsonProducts = jsonResponses['dataProducts'];

      for (var product in jsonProducts) {
        products.add(ProductModel.fromJson(product));
      }
    }
  } else {
    products = [];
    if (kDebugMode) {
      print(response.data);
    }
  }
  return products;
}

Future<DetailsProductModel> fetchProductDetails(int productID) async {
  final dio = Dio();
  Map<String, dynamic> data = {'MaSP': productID};
  DetailsProductModel productDetails = DetailsProductModel(
    maSp: "",
    maLsp: "",
    maDm: "",
    tenSp: "",
    donGia: "",
    soLuong: "",
    hinhAnh1: "",
    hinhAnh2: "",
    hinhAnh3: "",
    maKm: "",
    manHinh: "",
    hdh: "",
    camSau: "",
    camTruoc: "",
    cpu: "",
    ram: "",
    rom: "",
    sdCard: "",
    pin: "",
    soSao: "",
    soDanhGia: '',
    trangThai: "",
    moTa: "",
    thoiGian: "",
  );
  final response = await dio.get(
    AppRepositories.getProductsUrl,
    options: Options(
      contentType: 'application/json;charset=utf-8',
      responseType: ResponseType.plain,
    ),
    queryParameters: data,
  );
  if (response.statusCode == 200) {
    if (response.data != null) {
      var jsonResponses = jsonDecode(response.data);
      var jsonProducts = jsonResponses['dataProducts'];
      productDetails = DetailsProductModel.fromJson(jsonProducts);
    }
  } else {
    productDetails = DetailsProductModel(
      maSp: "",
      maLsp: "",
      maDm: "",
      tenSp: "",
      donGia: "",
      soLuong: "",
      hinhAnh1: "",
      hinhAnh2: "",
      hinhAnh3: "",
      maKm: "",
      manHinh: "",
      hdh: "",
      camSau: "",
      camTruoc: "",
      cpu: "",
      ram: "",
      rom: "",
      sdCard: "",
      pin: "",
      soSao: "",
      soDanhGia: '',
      trangThai: "",
      moTa: "",
      thoiGian: "",
    );
    if (kDebugMode) {
      print(response.data);
    }
  }
  return productDetails;
}

Future<List<ProductModel>> fetchProducts() async {
  final dio = Dio();
  var products = <ProductModel>[];

  final response = await dio.get(
    AppRepositories.getProductsUrl,
    options: Options(
      contentType: 'application/json;charset=utf-8',
      responseType: ResponseType.plain,
    ),
  );
  if (response.statusCode == 200) {
    if (response.data != null) {
      var jsonResponses = jsonDecode(response.data);
      var jsonProducts = jsonResponses['dataProducts'];

      for (var product in jsonProducts) {
        products.add(ProductModel.fromJson(product));
      }
    }
  } else {
    products = [];
    if (kDebugMode) {
      print(response.data);
    }
  }
  return products;
}

Future<List<CategoryModel>> fetchCategories() async {
  final dio = Dio();
  var categories = <CategoryModel>[];

  final response = await dio.get(
    AppRepositories.getCategoriesUrl,
    options: Options(
      contentType: 'application/json',
      responseType: ResponseType.plain,
    ),
  );

  if (response.statusCode == 200) {
    var jsonResponses = jsonDecode(response.data);
    var jsonCategories = jsonResponses['dataCategories'];

    for (var category in jsonCategories) {
      categories.add(CategoryModel.fromJson(category));
    }
  } else {
    categories = [];
    if (kDebugMode) {
      print(response.data);
    }
  }
  return categories;
}

Future<List<ProductTypeModel>> fetchProductTypes(int categoryID) async {
  final dio = Dio();
  Map<String, dynamic> data = {'MaDM': categoryID};
  var productTypes = <ProductTypeModel>[];

  final response = await dio.get(
    AppRepositories.getProductTypesUrl,
    options: Options(
      contentType: 'application/json;charset=utf-8',
      responseType: ResponseType.plain,
    ),
    queryParameters: data,
  );
  if (response.statusCode == 200) {
    if (response.data != null) {
      var jsonResponses = jsonDecode(response.data);
      var jsonProductTypes = jsonResponses['data'];

      for (var productType in jsonProductTypes) {
        productTypes.add(ProductTypeModel.fromJson(productType));
      }
    }
  } else {
    productTypes = [];
    if (kDebugMode) {
      print(response.data);
    }
  }
  return productTypes;
}

checkOutCart(
  int maND,
  String nguoiNhan,
  String sdt,
  String diaChi,
  String phuongThucTT,
  int tongTien,
  String trangThai,
  List<CartModel> sanPham,
  BuildContext context,
  bool mounted,
) async {
  Map data = {
    'MaND': maND,
    'NguoiNhan': nguoiNhan,
    'SDT': sdt,
    'DiaChi': diaChi,
    'PhuongThucTT': phuongThucTT,
    'TongTien': tongTien,
    'TrangThai': trangThai,
    'SanPham': sanPham,
  };
  final dio = Dio();
  try {
    var response = await dio.post(
      AppRepositories.paymentUrl,
      data: data,
      options: Options(
        contentType: 'application/json',
        responseType: ResponseType.plain,
      ),
    );
    if (response.statusCode == 201) {
      try {
        if (!mounted) return;
        TmpCart.cartItems.clear();
        Navigator.of(context, rootNavigator: true).push(
          MaterialPageRoute(
            builder: (BuildContext context) => const CheckoutCompletePage(),
          ),
        );
      } on Exception catch (e) {
        if (kDebugMode) {
          print(e.toString());
        }
      }
    } else {
      if (kDebugMode) {
        print(response.data);
      }
    }
  } on DioError catch (e) {
    debugPrint("${e.response} - ${e.message} - ${e.error} - $e");
    Fluttertoast.showToast(
      msg: "Checkout Error!",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 1,
      textColor: Colors.white,
      backgroundColor: Colors.red,
      fontSize: 16.0,
    );
  }
}

Future<List<HistoryModel>> fetchAllHistories(int userID) async {
  final dio = Dio();
  Map<String, dynamic> data = {'MaND': userID};
  var allHistories = <HistoryModel>[];

  final response = await dio.get(
    AppRepositories.getAllHistoriesUrl,
    options: Options(
      contentType: 'application/json;charset=utf-8',
      responseType: ResponseType.plain,
    ),
    queryParameters: data,
  );
  if (response.statusCode == 200) {
    if (response.data != null) {
      var jsonResponses = jsonDecode(response.data);
      var jsonProductTypes = jsonResponses['data'];

      for (var productType in jsonProductTypes) {
        allHistories.add(HistoryModel.fromJson(productType));
      }
    }
  } else {
    allHistories = [];
    if (kDebugMode) {
      print(response.data);
    }
  }
  return allHistories;
}
