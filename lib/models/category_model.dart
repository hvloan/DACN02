class CategoryModel {
  CategoryModel({
    required this.maDm,
    required this.tenDm,
  });

  String maDm;
  String tenDm;

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        maDm: json["MaDM"],
        tenDm: json["TenDM"],
      );

  Map<String, dynamic> toJson() => {
        "MaDM": maDm,
        "TenDM": tenDm,
      };
}
