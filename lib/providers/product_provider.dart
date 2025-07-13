import 'package:flutter/material.dart';
import '../models/product.dart';
import '../models/category.dart';
import '../services/api_service.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _products = [];
  List<Category> _categories = [];
  bool _isLoading = false;
  String _error = '';

  List<Product> get products => _products;
  List<Category> get categories => _categories;
  bool get isLoading => _isLoading;
  String get error => _error;

  List<Product> get featuredProducts => 
      _products.where((product) => product.isFeatured).toList();

  final ApiService _apiService = ApiService();

  Future<void> fetchCategories() async {
    _isLoading = true;
    _error = '';
    notifyListeners();

    try {
      _categories = await _apiService.getCategories();
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchProducts() async {
    _isLoading = true;
    _error = '';
    notifyListeners();

    try {
      _products = await _apiService.getProducts();
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchFeaturedProducts() async {
    _isLoading = true;
    _error = '';
    notifyListeners();

    try {
      _products = await _apiService.getFeaturedProducts();
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  List<Product> getProductsByCategory(String categoryId) {
    return _products.where((product) => product.category == categoryId).toList();
  }
}