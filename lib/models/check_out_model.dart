import 'package:flutter/foundation.dart';

import 'package:e_commerce_app/models/cart_model.dart';

class CheckoutModel {
  int maND;
  String nguoiNhan;
  String email;
  String sdt;
  String diaChi;
  String phuongThucTT;
  int tongTien;
  String trangThai;
  List<CartModel> items;

  CheckoutModel({
    required this.maND,
    required this.nguoiNhan,
    required this.email,
    required this.sdt,
    required this.diaChi,
    required this.phuongThucTT,
    required this.tongTien,
    required this.trangThai,
    required this.items,
  });

  CheckoutModel copyWith({
    int? maND,
    DateTime? ngayLap,
    String? nguoiNhan,
    String? email,
    String? sdt,
    String? diaChi,
    String? phuongThucTT,
    int? tongTien,
    String? trangThai,
    List<CartModel>? items,
  }) {
    return CheckoutModel(
      maND: maND ?? this.maND,
      nguoiNhan: nguoiNhan ?? this.nguoiNhan,
      email: email ?? this.email,
      sdt: sdt ?? this.sdt,
      diaChi: diaChi ?? this.diaChi,
      phuongThucTT: phuongThucTT ?? this.phuongThucTT,
      tongTien: tongTien ?? this.tongTien,
      trangThai: trangThai ?? this.trangThai,
      items: items ?? this.items,
    );
  }

  @override
  String toString() {
    return 'CheckoutModel(maND: $maND, nguoiNhan: $nguoiNhan, email: $email, sdt: $sdt, diaChi: $diaChi, phuongThucTT: $phuongThucTT, tongTien: $tongTien, trangThai: $trangThai, items: $items)';
  }

  @override
  bool operator ==(covariant CheckoutModel other) {
    if (identical(this, other)) return true;

    return other.maND == maND &&
        other.nguoiNhan == nguoiNhan &&
        other.email == email &&
        other.sdt == sdt &&
        other.diaChi == diaChi &&
        other.phuongThucTT == phuongThucTT &&
        other.tongTien == tongTien &&
        other.trangThai == trangThai &&
        listEquals(other.items, items);
  }

  @override
  int get hashCode {
    return maND.hashCode ^
        nguoiNhan.hashCode ^
        email.hashCode ^
        sdt.hashCode ^
        diaChi.hashCode ^
        phuongThucTT.hashCode ^
        tongTien.hashCode ^
        trangThai.hashCode ^
        items.hashCode;
  }
}
