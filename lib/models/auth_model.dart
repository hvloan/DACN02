import 'dart:convert';

AuthModel authModelFromJson(String str) => AuthModel.fromJson(json.decode(str));

String authModelToJson(AuthModel data) => json.encode(data.toJson());

class AuthModel {
  AuthModel({
    required this.maNd,
    required this.ho,
    required this.ten,
    required this.gioiTinh,
    required this.sdt,
    required this.email,
    required this.diaChi,
    required this.taiKhoan,
    required this.matKhau,
    required this.maQuyen,
    required this.trangThai,
  });

  String maNd;
  String ho;
  String ten;
  String gioiTinh;
  String sdt;
  String email;
  String diaChi;
  String taiKhoan;
  String matKhau;
  String maQuyen;
  String trangThai;

  factory AuthModel.fromJson(Map<String, dynamic> json) => AuthModel(
        maNd: json["MaND"],
        ho: json["Ho"],
        ten: json["Ten"],
        gioiTinh: json["GioiTinh"],
        sdt: json["SDT"],
        email: json["Email"],
        diaChi: json["DiaChi"],
        taiKhoan: json["TaiKhoan"],
        matKhau: json["MatKhau"],
        maQuyen: json["MaQuyen"],
        trangThai: json["TrangThai"],
      );

  Map<String, dynamic> toJson() => {
        "MaND": maNd,
        "Ho": ho,
        "Ten": ten,
        "GioiTinh": gioiTinh,
        "SDT": sdt,
        "Email": email,
        "DiaChi": diaChi,
        "TaiKhoan": taiKhoan,
        "MatKhau": matKhau,
        "MaQuyen": maQuyen,
        "TrangThai": trangThai,
      };
}
