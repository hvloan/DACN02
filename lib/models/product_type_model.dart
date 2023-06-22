class ProductTypeModel {
  ProductTypeModel({
    required this.maLsp,
    required this.tenLsp,
    required this.hinhAnh,
    required this.mota,
    required this.maDm,
  });

  String maLsp;
  String tenLsp;
  String hinhAnh;
  String mota;
  String maDm;

  factory ProductTypeModel.fromJson(Map<String, dynamic> json) =>
      ProductTypeModel(
        maLsp: json["MaLSP"],
        tenLsp: json["TenLSP"],
        hinhAnh: json["HinhAnh"],
        mota: json["Mota"],
        maDm: json["MaDM"],
      );

  Map<String, dynamic> toJson() => {
        "MaLSP": maLsp,
        "TenLSP": tenLsp,
        "HinhAnh": hinhAnh,
        "Mota": mota,
        "MaDM": maDm,
      };
}
