import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static late SharedPreferences sharedPreferences;

  saveUserPreferences(
    String maND,
    String ho,
    String ten,
    String gioiTinh,
    String sdt,
    String email,
    String diaChi,
    // String taiKhoan,
    // String matKhau,
  ) async {
    sharedPreferences = await SharedPreferences.getInstance();

    sharedPreferences.setString("MaND", maND);
    sharedPreferences.setString("Ho", ho);
    sharedPreferences.setString("Ten", ten);
    sharedPreferences.setString("GioiTinh", gioiTinh);
    sharedPreferences.setString("SDT", sdt);
    sharedPreferences.setString("Email", email);
    sharedPreferences.setString("DiaChi", diaChi);
    // sharedPreferences.setString("TaiKhoan", taiKhoan);
    // sharedPreferences.setString("MatKhau", matKhau);
  }

  deleteUserPreferences() async {
    sharedPreferences = await SharedPreferences.getInstance();

    sharedPreferences.setString("MaND", "");
    sharedPreferences.setString("Ho", "");
    sharedPreferences.setString("Ten", "");
    sharedPreferences.setString("GioiTinh", "");
    sharedPreferences.setString("SDT", "");
    sharedPreferences.setString("Email", "");
    sharedPreferences.setString("DiaChi", "");
    // sharedPreferences.setString("TaiKhoan", "");
    // sharedPreferences.setString("MatKhau", "");
  }
}
