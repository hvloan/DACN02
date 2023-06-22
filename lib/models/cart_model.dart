class CartModel {
  CartModel({
    required this.maSp,
    required this.tenSp,
    required this.hinhAnh,
    required this.donGia,
    required this.soLuong,
  });

  int maSp;
  String tenSp;
  String hinhAnh;
  String donGia;
  int soLuong;

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
        maSp: json["MaSP"],
        tenSp: json["TenSP"],
        hinhAnh: json["HinhAnh"],
        donGia: json["DonGia"],
        soLuong: json["SoLuong"],
      );

  Map<String, dynamic> toJson() => {
        "MaSP": maSp,
        "TenSP": tenSp,
        "HinhAnh": hinhAnh,
        "DonGia": donGia,
        "SoLuong": soLuong,
      };
}
