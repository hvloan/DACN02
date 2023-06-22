import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:e_commerce_app/models/auth_model.dart';
import 'package:e_commerce_app/networks/locals/shared_pref.dart';
import 'package:e_commerce_app/repositories/app_repositories.dart';
import 'package:e_commerce_app/screens/login_screen.dart';
import 'package:e_commerce_app/screens/app_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthEvent {
  static final sharedPreferences = SharedPref();

  loginAction(
    String userNameText,
    String passwordText,
    BuildContext context,
    bool mounted,
  ) async {
    Map data = {'TaiKhoan': userNameText, 'MatKhau': passwordText};
    final dio = Dio();
    try {
      var response = await dio.post(
        AppRepositories.loginUrl,
        data: data,
        options: Options(
          contentType: 'application/json',
          responseType: ResponseType.plain,
        ),
      );

      if (response.statusCode == 200) {
        try {
          Map<String, dynamic> jsonResponse = jsonDecode(
            response.data.toString(),
          );
          if (jsonResponse['status'] == 200) {
            Map<String, dynamic> dataUser = jsonResponse['dataUser'];
            sharedPreferences.saveUserPreferences(
              dataUser['MaND'],
              dataUser['Ho'],
              dataUser['Ten'],
              dataUser['GioiTinh'],
              dataUser['SDT'],
              dataUser['Email'],
              dataUser['DiaChi'],
              // dataUser['TaiKhoan'],
              // dataUser['MatKhau'],
            );
            if (!mounted) return;
            Fluttertoast.showToast(
              msg: "Login account successfully!",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.TOP,
              timeInSecForIosWeb: 1,
              textColor: Colors.white,
              backgroundColor: Colors.green,
              fontSize: 16.0,
            );
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) => const AppScreen(),
              ),
            );
          }
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
    } on DioError {
      Fluttertoast.showToast(
        msg: "UserName or Password not valid!",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        textColor: Colors.white,
        backgroundColor: Colors.red,
        fontSize: 16.0,
      );
    }
  }

  registerAction(
    String firstName,
    String lastName,
    String email,
    String phoneNumber,
    String userNameText,
    String passwordText,
    BuildContext context,
    bool mounted,
  ) async {
    Map data = {
      'Ho': firstName,
      'Ten': lastName,
      'Email': email,
      'SDT': phoneNumber,
      'TaiKhoan': userNameText,
      'MatKhau': passwordText
    };
    final dio = Dio();
    try {
      var response = await dio.post(
        AppRepositories.registerUrl,
        data: data,
        options: Options(
          contentType: 'application/json',
          responseType: ResponseType.plain,
        ),
      );

      if (response.statusCode == 201) {
        try {
          Map<String, dynamic> jsonResponse = jsonDecode(
            response.data.toString(),
          );
          if (jsonResponse['status'] == 201) {
            if (!mounted) return;
            Fluttertoast.showToast(
              msg: "Create account successfully!",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.TOP,
              timeInSecForIosWeb: 1,
              textColor: Colors.white,
              backgroundColor: Colors.green,
              fontSize: 16.0,
            );
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) => const LoginScreen(),
              ),
            );
          }
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
    } on DioError {
      Fluttertoast.showToast(
        msg: "Create account error. Username already exits!",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        textColor: Colors.white,
        backgroundColor: Colors.red,
        fontSize: 16.0,
      );
    }
  }

  updateUserAction(
    int id,
    String firstName,
    String lastName,
    String gender,
    String email,
    String phoneNumber,
    String address,
    BuildContext context,
    bool mounted,
    void setSate,
  ) async {
    Map<String, dynamic> data = {
      "Ho": firstName,
      "Ten": lastName,
      "GioiTinh": gender,
      "Email": email,
      "SDT": phoneNumber,
      "DiaChi": address
    };
    final dio = Dio();
    Map<String, dynamic> userID = {'MaND': id};
    try {
      var response = await dio.put(
        AppRepositories.updateUser,
        data: data,
        queryParameters: userID,
      );

      if (response.statusCode == 200) {
        try {
          if (!mounted) return;
          Fluttertoast.showToast(
            msg: "Update account successfully!",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 1,
            textColor: Colors.white,
            backgroundColor: Colors.green,
            fontSize: 16.0,
          );
          await SharedPref().saveUserPreferences(
            id.toString(),
            firstName,
            lastName,
            gender,
            phoneNumber,
            email,
            address,
          );
          setSate;
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
    } on DioError {
      Fluttertoast.showToast(
        msg: "Update account error. Already exits error!",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        textColor: Colors.white,
        backgroundColor: Colors.red,
        fontSize: 16.0,
      );
    }
  }

  signOutAction(BuildContext context, bool mounted) async {
    sharedPreferences.deleteUserPreferences();
    if (!mounted) return;
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => const LoginScreen(),
      ),
    );
  }

  Future<AuthModel> getDetailUser(int userID) async {
    final dio = Dio();
    Map<String, dynamic> data = {'MaND': userID};
    AuthModel authModel = AuthModel(
      maNd: "",
      ho: "",
      ten: "",
      email: "",
      gioiTinh: "",
      sdt: "",
      diaChi: "",
      taiKhoan: "",
      maQuyen: "",
      matKhau: "",
      trangThai: "",
    );
    final response = await dio.get(
      AppRepositories.getDetailsUserUrl,
      options: Options(
        contentType: 'application/json;charset=utf-8',
        responseType: ResponseType.plain,
      ),
      queryParameters: data,
    );
    if (response.statusCode == 200) {
      if (response.data != null) {
        var jsonResponses = jsonDecode(response.data);
        var jsonUser = jsonResponses['data'];
        authModel = AuthModel.fromJson(jsonUser);
      }
    } else {
      authModel = AuthModel(
        maNd: "",
        ho: "",
        ten: "",
        email: "",
        gioiTinh: "",
        sdt: "",
        diaChi: "",
        taiKhoan: "",
        maQuyen: "",
        matKhau: "",
        trangThai: "",
      );
      if (kDebugMode) {
        print(response.data);
      }
    }
    return authModel;
  }
}
