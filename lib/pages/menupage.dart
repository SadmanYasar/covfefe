import 'package:covfefe/datamanager.dart';
import 'package:covfefe/datamodel.dart';
import 'package:flutter/material.dart';

class MenuPage extends StatefulWidget {
  final DataManager dataManager;
  const MenuPage({super.key, required this.dataManager});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FutureBuilder(
        future: widget.dataManager.getMenu(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var categories = snapshot.data as List<Category>;
            return ListView.builder(
              itemCount: categories.length,
              itemBuilder: (context, index) {
                var category = categories[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        category.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      itemCount: category.products.length,
                      itemBuilder: (context, index) {
                        return ProductItem(
                          product: category.products[index],
                          onAdd: (p) => {
                            setState(() {
                              widget.dataManager.cartAdd(p);
                            }),
                          },
                        );
                      },
                    )
                  ],
                );
              },
            );
          } else if (snapshot.hasError) {
            return const Text("Error loading menu");
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}

class ProductItem extends StatelessWidget {
  final Product product;

  final Function onAdd;

  const ProductItem({super.key, required this.product, required this.onAdd});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 1,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Ink.image(
              image: Image.network(product.imageUrl).image,
              fit: BoxFit.cover,
              height: 240,
            ),
            // Image.asset(
            //   "images/black_coffee.png",
            //   fit: BoxFit.cover,
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        product.name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("\$${product.price.toStringAsFixed(2)}"),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () {
                      onAdd(product);
                    },
                    child: const Text("Add"),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
