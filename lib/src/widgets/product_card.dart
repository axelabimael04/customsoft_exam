import 'package:customsoft_exam/src/models/product_model.dart';
import 'package:customsoft_exam/src/pages/search/product_description_page.dart';
import 'package:customsoft_exam/src/utils/utils.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final ProductModel productModel;

  const ProductCard({super.key, required this.productModel});

  @override
  Widget build(BuildContext context) {
    double borderRadius = 10.0;
    return Card(
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(borderRadius),
                  bottomLeft: Radius.circular(borderRadius),
                ),
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  child: Image.network(
                    this.productModel.images.first,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        Icon(Icons.image_outlined, size: 30),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            this.productModel.title,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                        Text(
                          Utils.formatCurrency(this.productModel.amount),
                          style: Theme.of(context).textTheme.bodyLarge,
                        )
                      ],
                    ),
                    SizedBox(height: 5),
                    Text(
                      this.productModel.description,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => ProductDescriptionPage(
                                            productModel: this.productModel,
                                          )));
                            },
                            child: Text("Ver más"))
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
