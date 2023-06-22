import 'dart:math';

import 'package:e_commerce_app/constants/colors.dart';
import 'package:e_commerce_app/constants/tmp_cart.dart';
import 'package:e_commerce_app/constants/utils.dart';
import 'package:e_commerce_app/events/app_event.dart';
import 'package:e_commerce_app/models/cart_model.dart';
import 'package:e_commerce_app/models/details_product_model.dart';
import 'package:e_commerce_app/models/product_model.dart';
import 'package:e_commerce_app/repositories/app_repositories.dart';
import 'package:e_commerce_app/screens/pages/cart_page.dart';
import 'package:e_commerce_app/widgets/vl_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_plus/flutter_swiper_plus.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DetailsProductPage extends StatefulWidget {
  final int maSp;
  const DetailsProductPage({super.key, required this.maSp});

  @override
  State<DetailsProductPage> createState() => _DetailsProductPageState();
}

class _DetailsProductPageState extends State<DetailsProductPage> {
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
                onPressed: () => Navigator.pop(context),
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                )),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              child: IconButton(
                icon: Icon(
                  Icons.shopping_cart_rounded,
                  color:
                      TmpCart.cartItems.isNotEmpty ? Colors.red : Colors.white,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CartPage(),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: fetchProductDetails(widget.maSp),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              DetailsProductModel product = snapshot.data!;

              var listProductImages = [
                product.hinhAnh1,
                product.hinhAnh2,
                product.hinhAnh3
              ];
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(left: 12, right: 12, top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 200,
                        child: Swiper(
                          itemBuilder: (context, index) {
                            return Image.network(
                              "${AppRepositories.linkImageUrl}${listProductImages[index]}",
                            );
                          },
                          autoplay: false,
                          itemCount: listProductImages.length,
                          scrollDirection: Axis.horizontal,
                          pagination: const SwiperPagination(
                            alignment: Alignment.bottomCenter,
                          ),
                          control: const SwiperControl(),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        product.tenSp,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Text(
                          Utils.formatCurrency
                              .format(int.parse(product.donGia)),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 21,
                            color: Colors.red,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Html(
                        data: product.moTa,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      VLButton(
                        textLabelButton: const Text("ADD TO CART"),
                        colorTextLabelButton: Colors.white,
                        iconButton: const Icon(Icons.add_shopping_cart),
                        colorButton: VLColors.vlMainColor,
                        iconColorButton: Colors.white,
                        onPress: () {
                          CartModel itemCart = CartModel(
                            maSp: int.parse(product.maSp),
                            tenSp: product.tenSp,
                            hinhAnh: product.hinhAnh1,
                            donGia: product.donGia,
                            soLuong: 1,
                          );
                          debugPrint(itemCart.toJson().toString());
                          TmpCart.cartItems.add(itemCart);
                          Fluttertoast.showToast(
                            msg: "Add to Cart successfully!",
                            backgroundColor: Colors.green,
                            textColor: Colors.white,
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.TOP,
                          );
                          // Navigator.of(context).push(MaterialPageRoute(
                          //   builder: (_) => const CartPage(),
                          // ));
                          setState(() {});
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Technical Details',
                        style: TextStyle(
                          color: VLColors.vlMainColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Container(
                        color: Colors.white,
                        child: Table(
                          border: TableBorder.all(color: Colors.black),
                          children: [
                            const TableRow(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'Parameter',
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      color: VLColors.vlMainColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'Value',
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      color: VLColors.vlMainColor,
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
                                    'Screen',
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      color: VLColors.vlMainColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(product.manHinh),
                                ),
                              ],
                            ),
                            TableRow(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'Chip',
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      color: VLColors.vlMainColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(product.hdh),
                                ),
                              ],
                            ),
                            TableRow(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'System',
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      color: VLColors.vlMainColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(product.cpu),
                                ),
                              ],
                            ),
                            TableRow(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'RAM',
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      color: VLColors.vlMainColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(product.ram),
                                ),
                              ],
                            ),
                            TableRow(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'ROM',
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      color: VLColors.vlMainColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(product.rom),
                                ),
                              ],
                            ),
                            TableRow(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'Pin',
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      color: VLColors.vlMainColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(product.pin),
                                ),
                              ],
                            ),
                            TableRow(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'Font Camera',
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      color: VLColors.vlMainColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(product.camTruoc),
                                ),
                              ],
                            ),
                            TableRow(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'Rear Camera',
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      color: VLColors.vlMainColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(product.manHinh),
                                ),
                              ],
                            ),
                            TableRow(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'sdCard',
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      color: VLColors.vlMainColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(product.sdCard),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Products Recommend',
                        style: TextStyle(
                          color: VLColors.vlMainColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      SizedBox(
                        height: 200,
                        child: FutureBuilder(
                          future: fetchProductsByProductType(
                            int.parse(product.maDm),
                            int.parse(product.maLsp),
                          ),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              var listProduct = <ProductModel>[];
                              snapshot.data!.map((product) {
                                listProduct.add(product);
                              }).toList();
                              Random random = Random();
                              var listProductsRecommend = List.generate(
                                6,
                                (_) => listProduct[
                                    random.nextInt(listProduct.length)],
                              );
                              return ListView.builder(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemCount: listProductsRecommend.length,
                                padding: const EdgeInsets.all(8.0),
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () => {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              DetailsProductPage(
                                            maSp: int.parse(
                                                listProductsRecommend[index]
                                                    .maSp),
                                          ),
                                        ),
                                      ),
                                    },
                                    child: Card(
                                      elevation: 10,
                                      child: Container(
                                        alignment: Alignment.center,
                                        padding: const EdgeInsets.all(4.0),
                                        decoration: BoxDecoration(
                                          color: Colors.white30,
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              alignment: Alignment.center,
                                              height: 125,
                                              width: 150,
                                              child: AspectRatio(
                                                aspectRatio: 1.5,
                                                child: Image.network(
                                                  "${AppRepositories.linkImageUrl}${listProductsRecommend[index].hinhAnh1}",
                                                ),
                                              ),
                                            ),
                                            Text(
                                              listProductsRecommend[index]
                                                  .tenSp,
                                              style: const TextStyle(
                                                color: Colors.deepOrange,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              Utils.formatCurrency.format(
                                                int.parse(
                                                  listProductsRecommend[index]
                                                      .donGia,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            } else {
                              return const Center(
                                child: CircularProgressIndicator(
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
