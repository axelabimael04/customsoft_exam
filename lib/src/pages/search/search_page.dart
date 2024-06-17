import 'package:customsoft_exam/src/services/data/ads/ads_service.dart';
import 'package:customsoft_exam/src/models/ads_response_model.dart';
import 'package:customsoft_exam/src/widgets/product_card.dart';
import 'package:customsoft_exam/src/widgets/search_widget.dart';
import 'package:customsoft_exam/src/widgets/toggle_menu.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final ScrollController _scrollController = ScrollController();

  AdsResponseModel? ads;
  int initialItems = 5;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    AdsService.getAllAds().then((event) => setState(() => ads = event));

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        setState(() {
          isLoading = false;
          if (ads != null) {
            isLoading = true;
            if (initialItems + 5 <= ads!.items) {
              initialItems += 5;
            } else {
              isLoading = false;
            }
          }
        });
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
            ToggleMenu(
              items: [
                ToggleItem(title: "Autos", isSelected: true),
                ToggleItem(title: "Inmuebles"),
                ToggleItem(title: "Electrónicos"),
              ],
            ),
            SizedBox(height: 10),
            SearchWidget(),
            SizedBox(height: 10),
            Builder(
              builder: (context) {
                if (ads == null) return Container();
                int itemsCount =
                    ads!.items > initialItems ? initialItems : ads!.items;
                return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: itemsCount,
                  itemBuilder: (context, index) {
                    return ProductCard(productModel: ads!.ads[index]);
                  },
                );
              },
            ),
            Visibility(
              visible: isLoading,
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
          ],
        ),
      ),
    );
  }
}
