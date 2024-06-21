import 'package:customsoft_exam/src/models/product_model.dart';
import 'package:customsoft_exam/src/services/provider/search_provider.dart';
import 'package:customsoft_exam/src/widgets/product_card.dart';
import 'package:customsoft_exam/src/widgets/search_widget.dart';
import 'package:customsoft_exam/src/widgets/toggle_menu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    SearchProvider provider =
        Provider.of<SearchProvider>(context, listen: false);

    provider.init();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        provider.nextItems();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SearchProvider provider = Provider.of<SearchProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: ListView(
          physics: ClampingScrollPhysics(),
          controller: _scrollController,
          padding: EdgeInsets.all(10),
          children: [
            Text(
              "Buscador anuncio",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(height: 10),
            ToggleMenu<ProductType>(
              items: [
                ToggleItem<ProductType>(
                    title: "Autos",
                    isSelected: provider.isFilterSelected(ProductType.auto),
                    value: ProductType.auto),
                ToggleItem<ProductType>(
                    title: "Inmuebles",
                    isSelected: provider.isFilterSelected(ProductType.home),
                    value: ProductType.home),
                ToggleItem<ProductType>(
                    title: "Electrónicos",
                    isSelected:
                        provider.isFilterSelected(ProductType.electronic),
                    value: ProductType.electronic),
              ],
              onChanged: (value) {
                Provider.of<SearchProvider>(context, listen: false)
                    .updateFilterType(value.value as ProductType);
              },
            ),
            SizedBox(height: 10),
            SearchWidget(),
            SizedBox(height: 10),
            Visibility(
              visible: provider.searchResult.isEmpty &&
                  provider.searchValue.isNotEmpty,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("No hay coincidencias con '${provider.searchValue}' "),
                  ],
                ),
              ),
            ),
            Consumer<SearchProvider>(
              builder: (context, provider, child) {
                if (provider.productsToRender.isEmpty) return Container();

                int itemsCount = provider.renderedProductsCount;

                return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: itemsCount,
                  itemBuilder: (context, index) {
                    return ProductCard(
                        productModel: provider.productsToRender[index]);
                  },
                );
              },
            ),
            Visibility(
              visible: provider.searchValue.isEmpty,
              child: Visibility(
                visible: Provider.of<SearchProvider>(context).isloading,
                child: Padding(
                  padding: EdgeInsets.all(30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                    ],
                  ),
                ),
                replacement: Padding(
                  padding: EdgeInsets.all(30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Fin de los resultados"),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
