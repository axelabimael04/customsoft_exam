import 'package:customsoft_exam/src/models/product_model.dart';
import 'package:customsoft_exam/src/pages/search/seller_contact_form_page.dart';
import 'package:customsoft_exam/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';

class ProductDescriptionPage extends StatelessWidget {
  final ProductModel productModel;
  const ProductDescriptionPage({super.key, required this.productModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Detalle anuncio")),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          ListView(
            children: [
              _buildImagesSlider(),
              Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //Product name and price section
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                this.productModel.title,
                                style:
                                    Theme.of(context).textTheme.headlineLarge,
                              ),
                              SizedBox(height: 5),
                              Text(
                                Utils.formatCurrency(this.productModel.amount),
                                style: Theme.of(context).textTheme.titleSmall,
                              )
                            ],
                          ),
                        ),
                        //Product more info section
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(Icons.star_rounded),
                                SizedBox(width: 5),
                                Text(
                                  "${this.productModel.qualification}",
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  "${this.productModel.reviews} reviews",
                                  style: Theme.of(context).textTheme.bodySmall,
                                )
                              ],
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Theme.of(context).colorScheme.primary,
                              ),
                              onPressed: () {},
                              child: Text("Mapa"),
                            )
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 15),
                    Text(this.productModel.description),
                  ],
                ),
              ),
            ],
          ),
          _buildContactSellerButton(context)
        ],
      ),
    );
  }

  SafeArea _buildContactSellerButton(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 15)),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => SellerContactFormPage(
                                sellerContactModel:
                                    this.productModel.sellerContactModel,
                              )));
                },
                child: Text("Contactar vendedor"),
              ),
            )
          ],
        ),
      ),
    );
  }

  AspectRatio _buildImagesSlider() {
    //TODO: replace this part with the images of the product model
    List<String> assetsImages = ["assets/images/car1.jpeg", "assets/images/car2.jpeg"];
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Swiper(
        itemBuilder: (context, index) {
          return Image.asset(
            // this.productModel.images[index],
            assetsImages[index],
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Icon(Icons.image_outlined, size: 30),
          );
        },
        pagination: SwiperPagination(margin: EdgeInsets.all(5.0)),
        // itemCount: this.productModel.images.length,
        itemCount: assetsImages.length,
      ),
    );
  }
}
