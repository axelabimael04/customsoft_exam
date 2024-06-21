import 'package:customsoft_exam/src/models/product_model.dart';
import 'package:customsoft_exam/src/services/provider/search_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({super.key});

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    
    return Consumer<SearchProvider>(
      builder: (context, provider, child) {
        searchController.text = provider.searchValue;
        if (provider.searchValue.isEmpty){
          searchController.clear();
          FocusManager.instance.primaryFocus?.unfocus();
        }
        return CupertinoSearchTextField(
          controller: searchController,
          padding: EdgeInsets.all(10),
          keyboardType: TextInputType.name,
          onChanged: (String value) {
            onSearchTextChanged(value, provider);
          },
          onSubmitted: (String value) {
            onSearchTextChanged(value, provider);
          },
        );
      },
    );
  }

  void onSearchTextChanged(
    String text,
    SearchProvider provider,
  ) async {
    provider.searchValue = text;
    if (text.isEmpty) {
      provider.searchResult.clear();
      return;
    }

    List<ProductModel> searchResult = [];

    for (ProductModel product in provider.filteredProducts) {
      RegExp punctuationPattern = RegExp(r'[^\w\s]');
      String nameRaw = product.title.replaceAll(punctuationPattern, ' ');
      String nameRawNoSpaces = product.title.replaceAll(punctuationPattern, '');
      String nameLowerCase =
          product.title.toLowerCase().replaceAll(punctuationPattern, ' ');
      String nameLowerCaseNoSpaces =
          product.title.toLowerCase().replaceAll(punctuationPattern, '');

      List<String> coincidences = [
        nameRaw,
        nameRawNoSpaces,
        nameLowerCase,
        nameLowerCaseNoSpaces
      ];

      bool hasCoincidences = coincidences
          .where((element) => element.contains(text))
          .toList()
          .isNotEmpty;

      if (hasCoincidences) {
        searchResult.add(product);
        print("===== coincidencia");
      }
    }

    provider.searchResult = searchResult;
  }
}
