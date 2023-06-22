class ProductModel {
  ProductModel({
    required this.maSp,
    required this.maLsp,
    required this.maDm,
    required this.tenSp,
    required this.donGia,
    required this.soLuong,
    required this.hinhAnh1,
    required this.hinhAnh2,
    required this.hinhAnh3,
    required this.maKm,
    required this.manHinh,
    required this.hdh,
    required this.camSau,
    required this.camTruoc,
    required this.cpu,
    required this.ram,
    required this.rom,
    required this.sdCard,
    required this.pin,
    required this.soSao,
    required this.soDanhGia,
    required this.trangThai,
    // required this.moTa,
    // required this.thoiGian,
  });

  String maSp;
  String maLsp;
  String maDm;
  String tenSp;
  String donGia;
  String soLuong;
  String hinhAnh1;
  String hinhAnh2;
  String hinhAnh3;
  String maKm;
  String manHinh;
  String hdh;
  String camSau;
  String camTruoc;
  String cpu;
  String ram;
  String rom;
  String sdCard;
  String pin;
  String soSao;
  String soDanhGia;
  String trangThai;
  // String moTa;
  // DateTime thoiGian;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        maSp: json["MaSP"],
        maLsp: json["MaLSP"],
        maDm: json["MaDM"],
        tenSp: json["TenSP"],
        donGia: json["DonGia"],
        soLuong: json["SoLuong"],
        hinhAnh1: json["HinhAnh1"],
        hinhAnh2: json["HinhAnh2"],
        hinhAnh3: json["HinhAnh3"],
        maKm: json["MaKM"],
        manHinh: json["ManHinh"],
        hdh: json["HDH"],
        camSau: json["CamSau"],
        camTruoc: json["CamTruoc"],
        cpu: json["CPU"],
        ram: json["Ram"],
        rom: json["Rom"],
        sdCard: json["SDCard"],
        pin: json["Pin"],
        soSao: json["SoSao"],
        soDanhGia: json["SoDanhGia"],
        trangThai: json["TrangThai"],
        // moTa: json["MoTa"],
        // thoiGian: DateTime.parse(json["ThoiGian"]),
      );

  Map<String, dynamic> toJson() => {
        "MaSP": maSp,
        "MaLSP": maLsp,
        "MaDM": maDm,
        "TenSP": tenSp,
        "DonGia": donGia,
        "SoLuong": soLuong,
        "HinhAnh1": hinhAnh1,
        "HinhAnh2": hinhAnh2,
        "HinhAnh3": hinhAnh3,
        "MaKM": maKm,
        "ManHinh": manHinh,
        "HDH": hdh,
        "CamSau": camSau,
        "CamTruoc": camTruoc,
        "CPU": cpu,
        "Ram": ram,
        "Rom": rom,
        "SDCard": sdCard,
        "Pin": pin,
        "SoSao": soSao,
        "SoDanhGia": soDanhGia,
        "TrangThai": trangThai,
        // "MoTa": moTa,
        // "ThoiGian": thoiGian.toIso8601String(),
      };
}
