class HistoryModel {
  HistoryModel({
    required this.maHD,
    required this.maND,
    required this.ngayLap,
    required this.nguoiNhan,
    required this.sdt,
    required this.diaChi,
    required this.phuongThucTT,
    required this.tongTien,
    required this.trangThai,
  });

  String maHD;
  String maND;
  String ngayLap;
  String nguoiNhan;
  String sdt;
  String diaChi;
  String phuongThucTT;
  String tongTien;
  String trangThai;

  factory HistoryModel.fromJson(Map<String, dynamic> json) => HistoryModel(
        maHD: json["MaHD"],
        maND: json["MaND"],
        ngayLap: json["NgayLap"],
        nguoiNhan: json["NguoiNhan"],
        sdt: json["SDT"],
        diaChi: json["DiaChi"],
        phuongThucTT: json["PhuongThucThanhToan"],
        tongTien: json["TongTien"],
        trangThai: json["TrangThai"],
      );

  Map<String, dynamic> toJson() => {
        "MaHD": maHD,
        "MaND": maND,
        "NgayLap": ngayLap,
        "NguoiNhan": nguoiNhan,
        "SDT": sdt,
        "DiaChi": diaChi,
        "PhuongThucTT": phuongThucTT,
        "TongTien": tongTien,
        "TrangThai": trangThai,
      };
}
