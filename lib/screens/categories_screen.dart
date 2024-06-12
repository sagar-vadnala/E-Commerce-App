import 'package:e_commerce_app/screens/category_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/categories_model.dart';
import '../services/api_handler.dart';
import '../widgets/category_widgets.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Categories"),
      ),
      body: FutureBuilder<List<CategoriesModel>>(
        future: APIHandler.getAllCategories(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text("An error occurred: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No categories found"));
          }
          return GridView.builder(
            itemCount: snapshot.data!.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 0.0,
              mainAxisSpacing: 0.0,
              childAspectRatio: 1.2,
            ),
            itemBuilder: (ctx, index) {
              final categoryName = snapshot.data![index].name ?? "Unknown"; // Provide a default value for null

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CategoryProductsScreen(
                        categoryName: categoryName, // Pass non-nullable string
                      ),
                    ),
                  );
                },
                child: ChangeNotifierProvider.value(
                  value: snapshot.data![index],
                  child: const CategoryWidget(),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
