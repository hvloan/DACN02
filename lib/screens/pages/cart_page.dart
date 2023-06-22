import 'package:e_commerce_app/constants/colors.dart';
import 'package:e_commerce_app/constants/tmp_cart.dart';
import 'package:e_commerce_app/constants/utils.dart';
import 'package:e_commerce_app/models/check_out_model.dart';
import 'package:e_commerce_app/repositories/app_repositories.dart';
import 'package:e_commerce_app/screens/pages/check_out_page.dart';
import 'package:e_commerce_app/widgets/vl_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  TextEditingController textDisCountController = TextEditingController();
  int totalAmount = 0;
  String valueInputTextDialog = "";
  int giamGia = 0;
  int transport = 15000;
  int vat = 0;
  int totalPayment = 0;
  int maND = 0;
  String hoTen = "";
  String ten = "";
  String gioiTinh = "";
  String sdt = "";
  String email = "";
  String diaChi = "";
  static late SharedPreferences sharedPreferences;

  getInfoUser() async {
    sharedPreferences = await SharedPreferences.getInstance();
    maND = int.parse(sharedPreferences.getString("MaND")!);
    hoTen =
        "${sharedPreferences.getString("Ho")} ${sharedPreferences.getString("Ten")}";
    gioiTinh = sharedPreferences.getString("GioiTinh")!;
    sdt = sharedPreferences.getString("SDT")!;
    email = sharedPreferences.getString("Email")!;
    diaChi = sharedPreferences.getString("DiaChi")!;
  }

  @override
  void initState() {
    getInfoUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (TmpCart.cartItems.isEmpty) {
      return Scaffold(
        backgroundColor: VLColors.vlBackgroundColor,
        appBar: AppBar(
          backgroundColor: VLColors.vlBackgroundColor,
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: VLColors.vlMainColor,
              child: IconButton(
                  onPressed: () => Navigator.maybePop(context),
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  )),
            ),
          ),
        ),
        body: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.hourglass_empty_rounded,
                color: Colors.grey,
                size: 60.0,
              ),
              const SizedBox(height: 10.0),
              const Text(
                'Your cart is empty!!!',
                style: TextStyle(fontSize: 24.0, color: Colors.grey),
              ),
              TextButton(
                onPressed: () {
                  setState(() {});
                },
                child: const Text("Refresh"),
              ),
            ],
          ),
        ),
      );
    } else {
      totalAmount = 0;
      TmpCart.cartItems
          .map((item) => {totalAmount += int.parse(item.donGia) * item.soLuong})
          .toList();
      totalPayment = totalAmount - totalAmount * giamGia + transport + vat;
      return Scaffold(
        backgroundColor: VLColors.vlBackgroundColor,
        appBar: AppBar(
          backgroundColor: VLColors.vlBackgroundColor,
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: VLColors.vlMainColor,
              child: IconButton(
                  onPressed: () => Navigator.maybePop(context),
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  )),
            ),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 350,
                  child: ListView.separated(
                    shrinkWrap: true,
                    padding: const EdgeInsets.only(
                      bottom: 20,
                      left: 8,
                      right: 8,
                    ),
                    scrollDirection: Axis.vertical,
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(),
                    itemCount: TmpCart.cartItems.length,
                    itemBuilder: (BuildContext context, int index) {
                      var cartItem = TmpCart.cartItems[index];
                      return Padding(
                        padding: (index == 0)
                            ? const EdgeInsets.symmetric(vertical: 10.0)
                            : const EdgeInsets.only(bottom: 20.0),
                        child: Slidable(
                          key: Key('$cartItem'),
                          endActionPane: ActionPane(
                            motion: const ScrollMotion(),
                            children: [
                              SlidableAction(
                                onPressed: (context) {},
                                backgroundColor: Colors.teal,
                                icon: Icons.share,
                              ),
                              SlidableAction(
                                onPressed: (context) {
                                  TmpCart.cartItems.removeAt(index);
                                  setState(() {});
                                },
                                backgroundColor: Colors.red,
                                icon: Icons.delete,
                              ),
                            ],
                          ),
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 8.0),
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(
                                  blurStyle: BlurStyle.solid,
                                  color: Colors.orangeAccent,
                                  blurRadius: 8.0,
                                  spreadRadius: 3.0,
                                  offset: Offset(2, 3),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.network(
                                  "${AppRepositories.linkImageUrl}${cartItem.hinhAnh}",
                                  width: 100.0,
                                  height: 100.0,
                                  fit: BoxFit.cover,
                                ),
                                const SizedBox(width: 10.0),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      cartItem.tenSp,
                                      style: const TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 10.0),
                                    Text(
                                      Utils.formatCurrency
                                          .format(int.parse(cartItem.donGia)),
                                      style: const TextStyle(
                                        fontSize: 14.0,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        GestureDetector(
                                          child: const CircleAvatar(
                                            radius: 18,
                                            child: Icon(
                                              Icons.exposure_minus_1_rounded,
                                            ),
                                          ),
                                          onTap: () {
                                            if (cartItem.soLuong <= 1) {
                                            } else {
                                              cartItem.soLuong =
                                                  cartItem.soLuong - 1;
                                              setState(() {});
                                            }
                                          },
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        CircleAvatar(
                                          backgroundColor: Colors.deepOrange,
                                          radius: 15,
                                          child: CircleAvatar(
                                            backgroundColor: Colors.white,
                                            radius: 13,
                                            child: Text(
                                              cartItem.soLuong.toString(),
                                              style: const TextStyle(
                                                color: Colors.deepOrange,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        GestureDetector(
                                          child: const CircleAvatar(
                                            radius: 18,
                                            backgroundColor: Colors.deepOrange,
                                            child: Icon(
                                              Icons.plus_one_rounded,
                                            ),
                                          ),
                                          onTap: () {
                                            cartItem.soLuong =
                                                cartItem.soLuong + 1;
                                            setState(() {});
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Container(
                  padding: const EdgeInsets.only(
                    top: 15,
                    bottom: 15,
                    left: 20,
                    right: 20,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    border: Border.all(
                      color: VLColors.vlMainColor,
                      width: 2,
                    ),
                  ),
                  child: const Text(
                    'PAYMENT DETAILS',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Container(
                  margin: const EdgeInsets.all(10.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        blurStyle: BlurStyle.solid,
                        color: Colors.black,
                        blurRadius: 8.0,
                        spreadRadius: 1.0,
                        offset: Offset(0, 0),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        color: Colors.white,
                        child: Column(
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(10),
                              child: Text(
                                'Discount Code',
                                style: TextStyle(
                                  color: VLColors.vlMainColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 12,
                                right: 12,
                                bottom: 10,
                              ),
                              child: TextFormField(
                                controller: textDisCountController,
                                onChanged: (value) {
                                  setState(() {});
                                },
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                    vertical: 0,
                                    horizontal: 20,
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.blueAccent,
                                      width: 1.0,
                                    ),
                                  ),
                                  enabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.blueAccent,
                                      width: 1.0,
                                    ),
                                  ),
                                  suffixIcon: IconButton(
                                    icon: const Icon(Icons.close),
                                    onPressed: () {
                                      textDisCountController.clear();
                                    },
                                  ),
                                  prefixIcon:
                                      const Icon(Icons.discount_outlined),
                                  hintText: 'Enter discount here!',
                                  labelText: "Discount Code",
                                  labelStyle: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: VLButton(
                                  textLabelButton: const Text('CHECK CODE'),
                                  colorTextLabelButton: Colors.white,
                                  iconButton: const Icon(Icons.check),
                                  colorButton: Colors.black,
                                  iconColorButton: Colors.white,
                                  onPress: () {}),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Table(
                          border: TableBorder.all(color: Colors.black),
                          children: [
                            TableRow(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'Total Cart',
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      color: VLColors.vlMainColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    Utils.formatCurrency.format(totalAmount),
                                  ),
                                ),
                              ],
                            ),
                            TableRow(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'Discount',
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      color: VLColors.vlMainColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("$giamGia %"),
                                ),
                              ],
                            ),
                            TableRow(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'Transport',
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      color: VLColors.vlMainColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    Utils.formatCurrency.format(transport),
                                  ),
                                ),
                              ],
                            ),
                            TableRow(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'VAT',
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      color: VLColors.vlMainColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    Utils.formatCurrency.format(vat),
                                  ),
                                ),
                              ],
                            ),
                            TableRow(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'Total Amount',
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    Utils.formatCurrency.format(totalPayment),
                                    style: const TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: VLButton(
                          textLabelButton: const Text("CONTINUE"),
                          colorTextLabelButton: Colors.white,
                          iconButton: const Icon(Icons.payments_rounded),
                          colorButton: Colors.green,
                          iconColorButton: Colors.white,
                          onPress: () {
                            var checkoutModel = CheckoutModel(
                              maND: maND,
                              nguoiNhan: hoTen,
                              sdt: sdt,
                              diaChi: diaChi,
                              email: email,
                              phuongThucTT: "",
                              tongTien: totalPayment,
                              trangThai: "0",
                              items: TmpCart.cartItems,
                            );
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  CheckOutPage(checkoutModel: checkoutModel),
                            ));
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}
