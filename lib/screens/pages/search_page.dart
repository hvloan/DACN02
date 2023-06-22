import 'package:e_commerce_app/constants/colors.dart';
import 'package:e_commerce_app/constants/utils.dart';
import 'package:e_commerce_app/events/app_event.dart';
import 'package:e_commerce_app/models/product_model.dart';
import 'package:e_commerce_app/models/product_type_model.dart';
import 'package:e_commerce_app/repositories/app_repositories.dart';
import 'package:e_commerce_app/screens/pages/all_product_by_type_page.dart';
import 'package:e_commerce_app/screens/pages/details_product_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_simple_treeview/flutter_simple_treeview.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> with TickerProviderStateMixin {
  int currentIndexMenu = 0;

  TextEditingController keywordSearchController = TextEditingController();

  List<Tab> menuTabs = [
    const Tab(
      icon: Icon(Icons.keyboard_alt_rounded),
      text: 'By Keyword',
    ),
    const Tab(
      icon: Icon(Icons.grid_view_rounded),
      text: 'By Category',
    ),
    const Tab(
      icon: Icon(Icons.price_change_rounded),
      text: 'By Price',
    ),
  ];

  List<ProductModel> products = <ProductModel>[];

  String searchQuery = "";

  var nodeProductTypes = <TreeNode>[];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    keywordSearchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TabController menuTabsController = TabController(
      length: menuTabs.length,
      vsync: this,
    );

    return Scaffold(
      backgroundColor: VLColors.vlBackgroundColor,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: 80,
              child: menuTabBarWidget(menuTabsController),
            ),
            Flexible(
              child: SizedBox(
                width: double.infinity,
                child: menuTabBarViewWidget(menuTabsController),
              ),
            ),
          ],
        ),
      ),
    );
  }

  TabBarView menuTabBarViewWidget(TabController menuTabsController) {
    return TabBarView(
      controller: menuTabsController,
      children: [
        byKeywordWidget(),
        byCategoryWidget(),
        byPriceWidget(),
      ],
    );
  }

  FutureBuilder<List<ProductModel>> byPriceWidget() {
    return FutureBuilder(
      future: fetchProducts(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var listProduct = <ProductModel>[];
          snapshot.data!.map((product) {
            listProduct.add(product);
          }).toList();
          listProduct.sort(
            (a, b) => int.parse(a.donGia).compareTo(int.parse(b.donGia)),
          );
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
    );
  }

  Padding byCategoryWidget() {
    return Padding(
      padding: const EdgeInsets.only(left: 4, right: 4),
      child: Container(
        color: Colors.green,
        child: FutureBuilder(
          future: fetchCategories(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SingleChildScrollView(
                child: Column(
                  children: snapshot.data!
                      .map(
                        (category) => Column(
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.0),
                                ),
                                color: Colors.white,
                              ),
                              padding: const EdgeInsets.all(8),
                              margin: const EdgeInsets.only(top: 8),
                              child: Text(
                                category.tenDm.toUpperCase(),
                                style: const TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            FutureBuilder(
                              future:
                                  fetchProductTypes(int.parse(category.maDm)),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  var listProductType = <ProductTypeModel>[];
                                  snapshot.data!.map((productType) {
                                    listProductType.add(productType);
                                  }).toList();
                                  return ListView.builder(
                                    padding: const EdgeInsets.all(8.0),
                                    shrinkWrap: true,
                                    itemCount: snapshot.data!.length,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        color: Colors.white,
                                        padding: const EdgeInsets.all(8),
                                        margin: const EdgeInsets.only(top: 8),
                                        child: GestureDetector(
                                          onTap: () =>
                                              Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  AllProductByTypePage(
                                                maDM: int.parse(
                                                  listProductType[index].maDm,
                                                ),
                                                tenLSP: listProductType[index]
                                                    .tenLsp,
                                                maLSP: int.parse(
                                                  listProductType[index].maLsp,
                                                ),
                                              ),
                                            ),
                                          ),
                                          child: Row(
                                            children: [
                                              Image.network(
                                                "${AppRepositories.linkImageProductTypeUrl}${listProductType[index].hinhAnh}",
                                                fit: BoxFit.fill,
                                                width: 100,
                                                height: 25,
                                              ),
                                              Text(
                                                listProductType[index].tenLsp,
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              const Expanded(
                                                child: SizedBox(),
                                              ),
                                              const Icon(
                                                Icons.navigate_next_rounded,
                                                color: Colors.red,
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                } else {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      )
                      .toList(),
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }

  Padding byKeywordWidget() {
    return Padding(
      padding: const EdgeInsets.only(left: 4, right: 4),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: keywordSearchController,
              onChanged: (value) {
                setState(() {
                  searchQuery = value.toLowerCase();
                });
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
                    if (kDebugMode) {
                      keywordSearchController.clear();
                    }
                  },
                ),
                prefixIcon: const Icon(Icons.search_rounded),
                hintText: 'Enter product keyword here!',
                labelText: "Search",
                labelStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: fetchProducts(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Center(
                      child: ListView.separated(
                        padding: const EdgeInsets.only(top: 8),
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return snapshot.data![index].tenSp
                                  .toLowerCase()
                                  .contains(searchQuery)
                              ? Ink(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                      color: VLColors.vlMainColor,
                                      width: 1,
                                    ),
                                  ),
                                  child: ListTile(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              DetailsProductPage(
                                            maSp: int.parse(
                                              snapshot.data![index].maSp,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    leading: Image.network(
                                      "${AppRepositories.linkImageUrl}${snapshot.data?[index].hinhAnh1}",
                                      fit: BoxFit.fill,
                                      width: 50,
                                      height: 50,
                                    ),
                                    title:
                                        Text('${snapshot.data?[index].tenSp}'),
                                    subtitle: Text(
                                      Utils.formatCurrency.format(
                                        int.parse(snapshot.data![index].donGia),
                                      ),
                                      style: const TextStyle(color: Colors.red),
                                    ),
                                  ),
                                )
                              : Container();
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return snapshot.data![index].tenSp
                                  .toLowerCase()
                                  .contains(searchQuery)
                              ? const Divider(
                                  color: Colors.black,
                                  height: 15,
                                  thickness: 1.0,
                                )
                              : Container();
                        },
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return const Center(child: Text('Something went wrong :('));
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Card menuTabBarWidget(TabController menuTabsController) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.all(4),
      child: TabBar(
        labelColor: Colors.white,
        unselectedLabelColor: Colors.grey,
        labelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
        unselectedLabelStyle: const TextStyle(
          fontStyle: FontStyle.italic,
        ),
        overlayColor: MaterialStateColor.resolveWith(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed)) {
              return Colors.blue;
            }
            if (states.contains(MaterialState.focused)) {
              return Colors.orange;
            } else if (states.contains(MaterialState.hovered)) {
              return VLColors.vlMainColor;
            }

            return Colors.transparent;
          },
        ),
        indicatorWeight: 10,
        indicatorColor: Colors.red,
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorPadding: const EdgeInsets.all(5),
        indicator: BoxDecoration(
          border: Border.all(color: Colors.red),
          borderRadius: BorderRadius.circular(10),
          color: VLColors.vlMainColor,
        ),
        isScrollable: false,
        physics: const BouncingScrollPhysics(),
        onTap: (int index) {
          if (kDebugMode) {
            print('Tab $index is tapped');
          }
        },
        enableFeedback: true,
        tabs: menuTabs,
        controller: menuTabsController,
      ),
    );
  }
}
