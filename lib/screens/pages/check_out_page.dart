import 'package:e_commerce_app/constants/colors.dart';
import 'package:e_commerce_app/constants/utils.dart';
import 'package:e_commerce_app/events/app_event.dart';
import 'package:e_commerce_app/models/cart_model.dart';
import 'package:e_commerce_app/models/check_out_model.dart';
import 'package:e_commerce_app/widgets/vl_button.dart';
import 'package:flutter/material.dart';

class CheckOutPage extends StatefulWidget {
  const CheckOutPage({super.key, required this.checkoutModel});

  final CheckoutModel checkoutModel;

  @override
  State<CheckOutPage> createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  TextEditingController receiverNameTextController = TextEditingController();
  TextEditingController receiverEmailTextController = TextEditingController();
  TextEditingController receiverPhoneTextController = TextEditingController();
  TextEditingController receiverAddressTextController = TextEditingController();

  @override
  void initState() {
    receiverNameTextController.text = widget.checkoutModel.nguoiNhan;
    receiverEmailTextController.text = widget.checkoutModel.email;
    receiverPhoneTextController.text = widget.checkoutModel.sdt;
    receiverAddressTextController.text = widget.checkoutModel.diaChi;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Text(
                  'INFORMATION CHECKOUT',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 8,
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: VLColors.vlMainColor,
                      style: BorderStyle.solid,
                    ),
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'BILL',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Table(
                        columnWidths: const {
                          0: FlexColumnWidth(6),
                          1: FlexColumnWidth(4),
                        },
                        border: TableBorder.symmetric(
                          outside: const BorderSide(
                            color: Colors.black,
                            width: 1,
                          ),
                          inside: BorderSide.none,
                        ),
                        children: [
                          const TableRow(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Products',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Prices',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          for (var item in widget.checkoutModel.items)
                            tableRowCartItem(item),
                          const TableRow(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Discount',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  '0%',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.black,
                                  ),
                                ),
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
                                    fontSize: 16.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  Utils.formatCurrency.format(15000),
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
                                    fontSize: 16.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  Utils.formatCurrency.format(0),
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'TOTAL CHECKOUT',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  Utils.formatCurrency
                                      .format(widget.checkoutModel.tongTien),
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: VLColors.vlMainColor,
                      style: BorderStyle.solid,
                    ),
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'BILL DETAIL',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: receiverNameTextController,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.person),
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
                          hintText: 'Enter receiver name',
                          labelText: "Receiver Name",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        controller: receiverEmailTextController,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.email_rounded),
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
                          hintText: 'Enter receiver email',
                          labelText: "Receiver Email",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        controller: receiverPhoneTextController,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.phone_android_rounded),
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
                          hintText: 'Enter receiver phone number',
                          labelText: "Receiver Phone Number",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        controller: receiverAddressTextController,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.location_city_rounded),
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
                          hintText: 'Enter receiver address',
                          labelText: "Receiver Address",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      VLButton(
                        textLabelButton: const Text('PAYMENT'),
                        colorTextLabelButton: Colors.white,
                        iconButton: const Icon(Icons.check_rounded),
                        colorButton: Colors.green,
                        iconColorButton: Colors.white,
                        onPress: () {
                          checkOutCart(
                            widget.checkoutModel.maND,
                            receiverNameTextController.text,
                            receiverPhoneTextController.text,
                            receiverAddressTextController.text,
                            "",
                            widget.checkoutModel.tongTien,
                            "0",
                            widget.checkoutModel.items,
                            context,
                            mounted,
                          );
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  TableRow tableRowCartItem(CartModel item) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            '${item.tenSp} (${item.soLuong})',
            style: const TextStyle(
              fontSize: 16.0,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            Utils.formatCurrency.format(int.parse(item.donGia) * item.soLuong),
            style: const TextStyle(
              fontSize: 16.0,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
