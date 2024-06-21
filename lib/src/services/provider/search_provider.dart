import 'package:customsoft_exam/src/models/product_model.dart';
import 'package:customsoft_exam/src/services/data/ads/ads_service.dart';
import 'package:flutter/material.dart';

class SearchProvider extends ChangeNotifier {
  //Load values on provider
  List<ProductModel> _allProducts = [];
  int _initialItems = 0;
  bool _isLoading = true;
  Future<void> init() async {
    await AdsService.getAllAds().then((data) {
      if (data != null) {
        _allProducts = data.ads;
        _initialItems = 5;
        _isLoading = false;
      }
    });
    filterItems();
    notifyListeners();
  }

  int get initialItems => this._initialItems;
  bool get isloading => this._isLoading;

  //Filter values by ProductType

  ProductType _productFilter = ProductType.auto;
  ProductType get productFilter => this._productFilter;
  bool isFilterSelected(ProductType value) {
    return value == this._productFilter;
  }

  List<ProductModel> _filteredProducts = [];
  List<ProductModel> get filteredProducts => this._filteredProducts;

  void filterItems() {
    this._filteredProducts = _allProducts
        .where((element) => element.type == _productFilter)
        .toList();
    notifyListeners();
  }

  // search product by filtered elements

  String _searchValue = "";
  String get searchValue => this._searchValue;
  set searchValue(String value) {
    this._searchValue = value;
    // notifyListeners();
  }

  List<ProductModel> _searchResult = [];

  List<ProductModel> get searchResult => this._searchResult;

  set searchResult(List<ProductModel> values) {
    this._searchResult = values;
    notifyListeners();
  }

  //elements  rendering

  List<ProductModel> get productsToRender =>
      this._searchResult.isEmpty ? this._filteredProducts : this._searchResult;

  int get renderedProductsCount => productsToRender.length > initialItems
      ? initialItems
      : productsToRender.length;

  void nextItems() {
    _isLoading = false;
    if (_filteredProducts.isNotEmpty) {
      _isLoading = true;
      if (initialItems + 5 <= _filteredProducts.length) {
        _initialItems += 5;
      } else {
        _isLoading = false;
      }
    }
    notifyListeners();
  }

  void updateFilterType(ProductType filter) {
    this._productFilter = filter;
    this._searchValue = "";
    this._searchResult.clear();
    filterItems();
    notifyListeners();
  }
}
