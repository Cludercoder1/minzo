import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product.dart';
import '../models/category.dart';

class ApiService {
  // Replace with your actual backend URL
  static const String baseUrl = 'https://your-domain.com/api';
  
  // For development, you can use sample data
  static const bool useSampleData = true;

  Future<List<Category>> getCategories() async {
    if (useSampleData) {
      return _getSampleCategories();
    }

    try {
      final response = await http.get(
        Uri.parse('$baseUrl/categories.php'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Category.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load categories');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  Future<List<Product>> getProducts() async {
    if (useSampleData) {
      return _getSampleProducts();
    }

    try {
      final response = await http.get(
        Uri.parse('$baseUrl/products.php'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Product.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  Future<List<Product>> getFeaturedProducts() async {
    if (useSampleData) {
      return _getSampleProducts().where((p) => p.isFeatured).toList();
    }

    try {
      final response = await http.get(
        Uri.parse('$baseUrl/featured_products.php'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Product.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load featured products');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  // Sample data for development
  List<Category> _getSampleCategories() {
    return [
      Category(
        id: '1',
        name: 'Fruits',
        imageUrl: 'https://images.pexels.com/photos/1132047/pexels-photo-1132047.jpeg?auto=compress&cs=tinysrgb&w=400',
      ),
      Category(
        id: '2',
        name: 'Vegetables',
        imageUrl: 'https://images.pexels.com/photos/1300972/pexels-photo-1300972.jpeg?auto=compress&cs=tinysrgb&w=400',
      ),
      Category(
        id: '3',
        name: 'Dairy',
        imageUrl: 'https://images.pexels.com/photos/236010/pexels-photo-236010.jpeg?auto=compress&cs=tinysrgb&w=400',
      ),
      Category(
        id: '4',
        name: 'Snacks',
        imageUrl: 'https://images.pexels.com/photos/1640777/pexels-photo-1640777.jpeg?auto=compress&cs=tinysrgb&w=400',
      ),
      Category(
        id: '5',
        name: 'Beverages',
        imageUrl: 'https://images.pexels.com/photos/544961/pexels-photo-544961.jpeg?auto=compress&cs=tinysrgb&w=400',
      ),
    ];
  }

  List<Product> _getSampleProducts() {
    return [
      Product(
        id: '1',
        title: 'Fresh Apples',
        description: 'Crispy red apples, perfect for snacking',
        price: 150.0,
        imageUrl: 'https://images.pexels.com/photos/102104/pexels-photo-102104.jpeg?auto=compress&cs=tinysrgb&w=400',
        category: '1',
        isFeatured: true,
        rating: 4.5,
        stock: 50,
      ),
      Product(
        id: '2',
        title: 'Organic Bananas',
        description: 'Sweet and nutritious organic bananas',
        price: 80.0,
        imageUrl: 'https://images.pexels.com/photos/2872755/pexels-photo-2872755.jpeg?auto=compress&cs=tinysrgb&w=400',
        category: '1',
        isFeatured: true,
        rating: 4.3,
        stock: 30,
      ),
      Product(
        id: '3',
        title: 'Fresh Milk',
        description: 'Pure and fresh dairy milk',
        price: 120.0,
        imageUrl: 'https://images.pexels.com/photos/248412/pexels-photo-248412.jpeg?auto=compress&cs=tinysrgb&w=400',
        category: '3',
        isFeatured: true,
        rating: 4.7,
        stock: 25,
      ),
      Product(
        id: '4',
        title: 'Potato Chips',
        description: 'Crispy and delicious potato chips',
        price: 60.0,
        imageUrl: 'https://images.pexels.com/photos/1640777/pexels-photo-1640777.jpeg?auto=compress&cs=tinysrgb&w=400',
        category: '4',
        isFeatured: false,
        rating: 4.1,
        stock: 40,
      ),
      Product(
        id: '5',
        title: 'Orange Juice',
        description: 'Fresh squeezed orange juice',
        price: 180.0,
        imageUrl: 'https://images.pexels.com/photos/96974/pexels-photo-96974.jpeg?auto=compress&cs=tinysrgb&w=400',
        category: '5',
        isFeatured: true,
        rating: 4.6,
        stock: 20,
      ),
      Product(
        id: '6',
        title: 'Fresh Tomatoes',
        description: 'Red ripe tomatoes for cooking',
        price: 90.0,
        imageUrl: 'https://images.pexels.com/photos/533280/pexels-photo-533280.jpeg?auto=compress&cs=tinysrgb&w=400',
        category: '2',
        isFeatured: true,
        rating: 4.4,
        stock: 35,
      ),
    ];
  }
}