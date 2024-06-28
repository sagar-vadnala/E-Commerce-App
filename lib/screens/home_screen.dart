import 'package:card_swiper/card_swiper.dart';
import 'package:e_commerce_app/cart/cart.dart';
import 'package:e_commerce_app/conts/global_colors.dart';
import 'package:e_commerce_app/models/product_model.dart';
import 'package:e_commerce_app/provider/auth-provider.dart';
import 'package:e_commerce_app/screens/categories_screen.dart';
import 'package:e_commerce_app/screens/feeds_screen.dart';
import 'package:e_commerce_app/screens/search_page_result.dart';
import 'package:e_commerce_app/screens/users_screen.dart';
import 'package:e_commerce_app/services/api_handler.dart';
import 'package:e_commerce_app/widgets/appbar_icons.dart';
import 'package:e_commerce_app/widgets/feed_grid.dart';
import 'package:e_commerce_app/widgets/sale_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  static List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    FeedsScreen(),
    CategoriesScreen(),
    CartPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/');
        break;
      case 1:
        Navigator.pushNamed(context, '/all_products');
        break;
      case 2:
        Navigator.pushNamed(context, '/categories');
        break;
      case 3:
        Navigator.pushNamed(context, '/cart');
        break;
      default:
        break;
    }
  }

  late TextEditingController _textEditingController;
  List<ProductModel> staticResults = [];

  @override
  void initState() {
    _textEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  Future<bool> _onWillPop() async {
    if (_selectedIndex != 0) {
      setState(() {
        _selectedIndex = 0;
      });
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: _onWillPop,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Home"),
            leading: AppBarIcons(
              function: () {
                Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.fade,
                      child: const CategoriesScreen()),
                );
              },
              icon: IconlyBold.category,
            ),
            actions: [
              // AppBarIcons(
              //   function: () {
              //     Navigator.push(
              //       context,
              //       PageTransition(
              //         type: PageTransitionType.fade,
              //         child: const UsersScreen(),
              //       ),
              //     );
              //   },
              //   icon: IconlyBold.user3,
              // ),
              // IconButton(
              //   icon: const Icon(Icons.logout),
              //   onPressed: () {
              //     authProvider.logout();
              //     Navigator.pushReplacementNamed(context, '/login');
              //   },
              // ),
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CartPage(),
                    ),
                  );
                },
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            SearchResultsPage(staticResults: staticResults),
                      ),
                    );
                  },
                  child: TextField(
                    controller: _textEditingController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: "Search",
                      filled: true,
                      fillColor: Theme.of(context).cardColor,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide:
                            BorderSide(color: Theme.of(context).cardColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                            width: 1,
                            color: Theme.of(context).colorScheme.secondary),
                      ),
                      suffixIcon:
                          Icon(IconlyLight.search, color: lightIconsColor),
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: size.height * 0.25,
                          child: Swiper(
                            itemCount: 3,
                            itemBuilder: (ctx, index) => const SaleWidget(),
                            autoplay: true,
                            pagination: const SwiperPagination(
                              alignment: Alignment.bottomCenter,
                              builder: DotSwiperPaginationBuilder(
                                  color: Colors.white, activeColor: Colors.red),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              const Text(
                                "Latest Products",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 18),
                              ),
                              const Spacer(),
                              AppBarIcons(
                                function: () {
                                  Navigator.push(
                                    context,
                                    PageTransition(
                                        type: PageTransitionType.fade,
                                        child: const FeedsScreen()),
                                  );
                                },
                                icon: IconlyBold.arrowRight3,
                              ),
                            ],
                          ),
                        ),
                        FutureBuilder<List<ProductModel>>(
                          future: APIHandler.getAllProducts(limit: "3"),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              return Center(
                                  child: Text(
                                      "An error occurred: ${snapshot.error}"));
                            } else if (!snapshot.hasData ||
                                snapshot.data!.isEmpty) {
                              return const Center(
                                  child: Text("No products found"));
                            }
                            snapshot.data!.forEach((product) {
                              print(
                                  "Product: ${product.title}, Image URL: ${product.image}");
                            });
                            return FeedsGridWidget(productsList: snapshot.data!);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.blue,
            onTap: _onItemTapped,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.list),
                label: 'All Products',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.category),
                label: 'Categories',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart),
                label: 'Cart',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
