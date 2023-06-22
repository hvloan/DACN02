import 'package:e_commerce_app/constants/colors.dart';
import 'package:e_commerce_app/constants/utils.dart';
import 'package:e_commerce_app/events/app_event.dart';
import 'package:e_commerce_app/models/product_model.dart';
import 'package:e_commerce_app/repositories/app_repositories.dart';
import 'package:e_commerce_app/screens/pages/details_product_page.dart';
import 'package:flutter/material.dart';

class AllProductByTypePage extends StatefulWidget {
  final int maDM;
  final int maLSP;
  final String tenLSP;
  const AllProductByTypePage(
      {super.key,
      required this.maDM,
      required this.tenLSP,
      required this.maLSP});

  @override
  State<AllProductByTypePage> createState() => _AllProductByTypePageState();
}

class _AllProductByTypePageState extends State<AllProductByTypePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: VLColors.vlBackgroundColor,
      appBar: AppBar(
        title: Text(
          widget.tenLSP.toUpperCase(),
          style: const TextStyle(
            color: Colors.red,
          ),
        ),
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
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: fetchProductsByProductType(widget.maDM, widget.maLSP),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var listProduct = <ProductModel>[];
              snapshot.data!.map((product) {
                listProduct.add(product);
              }).toList();
              return GridView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: listProduct.length,
                  padding: const EdgeInsets.all(8.0),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                  ),
                  itemBuilder: (_, index) {
                    return GestureDetector(
                      onTap: () => {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => DetailsProductPage(
                              maSp: int.parse(listProduct[index].maSp),
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
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                alignment: Alignment.center,
                                height: 125,
                                width: 150,
                                child: AspectRatio(
                                  aspectRatio: 1.3,
                                  child: Image.network(
                                    "${AppRepositories.linkImageUrl}${listProduct[index].hinhAnh1}",
                                  ),
                                ),
                              ),
                              Text(
                                listProduct[index].tenSp,
                                style: const TextStyle(
                                  color: Colors.deepOrange,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                Utils.formatCurrency.format(
                                  int.parse(listProduct[index].donGia),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  });
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
