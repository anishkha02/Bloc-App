import 'dart:convert';
import 'package:http/http.dart' as http;  

import 'package:infoware_app/data/models/product_model.dart';

class ProductRepository {
  final String baseUrl;

  ProductRepository({this.baseUrl = 'https://dummyjson.com/products'});
  
  

  Future<List<Product>> getProducts() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        final List productsJson = data['products'];
        return productsJson.map((json) => Product.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception('Error fetching products: $e');
    }
  }
}

