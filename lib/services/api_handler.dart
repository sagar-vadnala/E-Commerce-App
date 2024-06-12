import 'dart:convert';
import 'package:e_commerce_app/models/product_model.dart';
import 'package:e_commerce_app/models/users_model.dart';
import 'package:e_commerce_app/models/categories_model.dart'; // Add this import
import 'package:http/http.dart' as http;

class APIHandler {
  static const String baseUrl = 'https://fakestoreapi.com';


  static Future<List<ProductModel>> getProductsByCategory(String category) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/products/category/$category'));
      if (response.statusCode != 200) {
        throw Exception('Failed to load products');
      }
      List<dynamic> data = json.decode(response.body);
      return data.map((item) => ProductModel.fromJson(item)).toList();
    } catch (error) {
      print('Error fetching products by category: $error');
      throw error;
    }
  }

  static Future<List<ProductModel>> getAllProducts({String limit = '10'}) async {
    final response = await http.get(Uri.parse('$baseUrl/products?limit=$limit'));
    if (response.statusCode != 200) {
      throw Exception('Failed to load products');
    }
    List<dynamic> data = json.decode(response.body);
    return data.map((item) => ProductModel.fromJson(item)).toList();
  }

  static Future<ProductModel> getProductById(String id) async {
    final response = await http.get(Uri.parse('$baseUrl/products/$id'));
    if (response.statusCode != 200) {
      throw Exception('Failed to load product');
    }
    return ProductModel.fromJson(json.decode(response.body));
  }

  static Future<List<UsersModel>> getAllUsers() async {
    final response = await http.get(Uri.parse('$baseUrl/users'));
    if (response.statusCode != 200) {
      throw Exception('Failed to load users');
    }
    List<dynamic> data = json.decode(response.body);
    return data.map((item) => UsersModel.fromJson(item)).toList();
  }

  // Define getAllCategories method
  static Future<List<CategoriesModel>> getAllCategories() async {
    final response = await http.get(Uri.parse('$baseUrl/products/categories'));
    if (response.statusCode != 200) {
      throw Exception('Failed to load categories');
    }
    List<dynamic> data = json.decode(response.body);
    return data.map((item) => CategoriesModel(name: item.toString())).toList();
  }
}
