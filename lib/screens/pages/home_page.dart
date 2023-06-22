import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce_app/constants/colors.dart';
import 'package:e_commerce_app/constants/utils.dart';
import 'package:e_commerce_app/events/app_event.dart';
import 'package:e_commerce_app/models/product_model.dart';
import 'package:e_commerce_app/repositories/app_repositories.dart';
import 'package:e_commerce_app/screens/pages/details_product_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final _carouselImages = [
    "assets/images/slide01.png",
    "assets/images/slide02.png",
    "assets/images/slide03.png",
    "assets/images/slide04.png",
  ];

  @override
  Widget build(BuildContext context) {
    TabController tabBarController = TabController(
      length: 0,
      vsync: this,
    );

    return Scaffold(
      backgroundColor: VLColors.vlBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 8,
              ),
              AspectRatio(
                aspectRatio: 3.0,
                child: CarouselSlider(
                  items: _carouselImages
                      .map((item) => Padding(
                            padding: const EdgeInsets.only(left: 3, right: 3),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(10),
                                ),
                                image: DecorationImage(
                                  image: AssetImage(item),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ))
                      .toList(),
                  options: CarouselOptions(
                    autoPlay: true,
                    enlargeCenterPage: true,
                    viewportFraction: 1,
                    enlargeStrategy: CenterPageEnlargeStrategy.height,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Categories',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    InkWell(
                      child: const Text('View all'),
                      onTap: () {
                        if (kDebugMode) {
                          print('Click View all Categories');
                        }
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              FutureBuilder(
                future: fetchCategories(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    tabBarController = TabController(
                      length: snapshot.data!.length,
                      vsync: this,
                    );
                    return Column(
                      children: [
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 5,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white10,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: TabBar(
                              indicator: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: VLColors.vlMainColor,
                              ),
                              controller: tabBarController,
                              labelPadding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              tabs: snapshot.data!.map((category) {
                                return Tab(
                                  child: Text(
                                    category.tenDm.toUpperCase(),
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 200,
                          child: TabBarView(
                            controller: tabBarController,
                            children: snapshot.data!.map((category) {
                              return FutureBuilder(
                                future: fetchProductsByCategory(
                                  int.parse(category.maDm),
                                ),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    var listProduct = <ProductModel>[];
                                    snapshot.data!.map((product) {
                                      listProduct.add(product);
                                    }).toList();
                                    return ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: snapshot.data!.length,
                                      padding: const EdgeInsets.all(8.0),
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () => {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    DetailsProductPage(
                                                  maSp: int.parse(
                                                      listProduct[index].maSp),
                                                ),
                                              ),
                                            ),
                                          },
                                          child: Card(
                                            elevation: 10,
                                            child: Container(
                                              alignment: Alignment.center,
                                              padding:
                                                  const EdgeInsets.all(4.0),
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
                                                        "${AppRepositories.linkImageUrl}${listProduct[index].hinhAnh1}",
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    listProduct[index].tenSp,
                                                    style: const TextStyle(
                                                      color: Colors.deepOrange,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  Text(
                                                    Utils.formatCurrency.format(
                                                      int.parse(
                                                        listProduct[index]
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
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    );
                  } else {
                    return const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
              ),
              const SizedBox(
                height: 4,
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height / 4,
                  child: ListView.builder(
                    itemCount: 2,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Container(
                        color: Colors.orangeAccent,
                        margin: const EdgeInsets.all(4),
                        height: MediaQuery.of(context).size.height / 3,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 2, right: 2),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: Column(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(
                                    left: 8,
                                    right: 8,
                                    top: 10,
                                  ),
                                  child: Text(
                                    '20% OFF DURING THE WEEKEND',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    ElevatedButton.icon(
                                      onPressed: () {},
                                      label: const Text(
                                        'Get Now',
                                        style: TextStyle(
                                          color: VLColors.vlMainColor,
                                        ),
                                      ),
                                      icon: const Icon(
                                          Icons.trending_flat_outlined),
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.white),
                                        iconColor: MaterialStateProperty.all(
                                            VLColors.vlMainColor),
                                        padding: MaterialStateProperty.all(
                                          const EdgeInsets.all(10),
                                        ),
                                        textStyle: MaterialStateProperty.all(
                                          const TextStyle(
                                            color: VLColors.vlMainColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        shape: MaterialStateProperty.all(
                                            const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10),
                                          ),
                                        )),
                                      ),
                                    ),
                                    Image.asset(
                                      'assets/images/hand_holding_shopping.png',
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
              ),
              const SizedBox(
                height: 8,
              ),
              const Text(
                'TOP PRODUCTS BEST SELLERS',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              SizedBox(
                height: 450,
                child: FutureBuilder(
                  future: fetchProducts(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      var listProduct = <ProductModel>[];
                      snapshot.data!.map((product) {
                        listProduct.add(product);
                      }).toList();
                      Random random = Random();
                      var listProductsBestSeller = List.generate(
                        8,
                        (_) => listProduct[random.nextInt(listProduct.length)],
                      );
                      return GridView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: listProductsBestSeller.length,
                          padding: const EdgeInsets.all(8.0),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
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
                                      maSp: int.parse(
                                          listProductsBestSeller[index].maSp),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        alignment: Alignment.center,
                                        height: 125,
                                        width: 150,
                                        child: AspectRatio(
                                          aspectRatio: 1.3,
                                          child: Image.network(
                                            "${AppRepositories.linkImageUrl}${listProductsBestSeller[index].hinhAnh1}",
                                          ),
                                        ),
                                      ),
                                      Text(
                                        listProductsBestSeller[index].tenSp,
                                        style: const TextStyle(
                                          color: Colors.deepOrange,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        Utils.formatCurrency.format(
                                          int.parse(
                                              listProductsBestSeller[index]
                                                  .donGia),
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
            ],
          ),
        ),
      ),
    );
  }
}
