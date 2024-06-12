import 'dart:developer';
import 'package:card_swiper/card_swiper.dart';
import 'package:e_commerce_app/cart/cart.dart';
import 'package:e_commerce_app/conts/global_colors.dart';
import 'package:e_commerce_app/models/product_model.dart';
import 'package:e_commerce_app/provider/cart_provider.dart';
import 'package:e_commerce_app/services/api_handler.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key, required this.id});
  final String id;

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  final titleStyle = const TextStyle(fontSize: 24, fontWeight: FontWeight.bold);
  ProductModel? productModel;
  bool isError = false;
  String errorStr = "";

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _fetchProductInfo();
  }

  Future<void> _fetchProductInfo() async {
    try {
      productModel = await APIHandler.getProductById(widget.id);
    } catch (error) {
      setState(() {
        isError = true;
        errorStr = error.toString();
        log("error $error");
      });
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Product Details'),
        actions: [
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
      body: SafeArea(
        child: isError
            ? Center(child: Text("An error occurred: $errorStr", style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w500)))
            : productModel == null
                ? const Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const SizedBox(height: 18),
                        const BackButton(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(productModel!.category, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
                              const SizedBox(height: 18),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    flex: 3,
                                    child: Text(productModel!.title, textAlign: TextAlign.start, style: titleStyle),
                                  ),
                                  Flexible(
                                    flex: 1,
                                    child: RichText(
                                      text: TextSpan(
                                        text: '\$',
                                        style: const TextStyle(fontSize: 25, color: Color.fromRGBO(33, 150, 243, 1)),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: productModel!.price.toString(),
                                            style: TextStyle(color: lightTextColor, fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.4,
                          child: Swiper(
                            itemBuilder: (context, index) => FancyShimmerImage(
                              width: double.infinity,
                              imageUrl: productModel!.image,
                              boxFit: BoxFit.fill,
                            ),
                            autoplay: true,
                            itemCount: 1,
                            pagination: const SwiperPagination(
                              alignment: Alignment.bottomCenter,
                              builder: DotSwiperPaginationBuilder(color: Colors.white, activeColor: Colors.red),
                            ),
                          ),
                        ),
                        const SizedBox(height: 18),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Description", style: titleStyle),
                              Text(
                                productModel!.description,
                                textAlign: TextAlign.start,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 18),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20.0),
                          child: Center(
                            child: ElevatedButton(
                              onPressed: () {
                                Provider.of<CartProvider>(context, listen: false).addToCart(productModel!);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Product added to cart')),
                                );
                              },
                              child: const Text('Add to Cart', style: TextStyle(fontSize: 20)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
      ),
    );
  }
}
