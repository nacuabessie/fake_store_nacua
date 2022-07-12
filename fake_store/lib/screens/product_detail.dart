import 'package:flutter/material.dart';

import '../models/product.dart';
import '../services/api_service.dart';

class ProductDetailScreen extends StatelessWidget {
  int id;
  ProductDetailScreen({Key? key, required this.id}) : super(key: key);
  ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
      ),
      body: Container(
        margin: const EdgeInsets.all(20),
        child: FutureBuilder(
          future: apiService.getProduct(id),
          builder: (BuildContext context, AsyncSnapshot<Product?> snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            final product = snapshot.data;

            if (product == null) {
              return const Center(
                child: Text(
                  'No product found.',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 24,
                  ),
                ),
              );
            }

            return SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  Image.network(
                    '[image]',
                    height: 200,
                    width: double.infinity,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    product.price.toString(),
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    product.title!,
                    style: const TextStyle(
                      fontSize: 25,
                    ),
                  ),
                  Chip(
                    label: Text(
                      product.category!,
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                    backgroundColor: Colors.blueGrey,
                  ),
                  const SizedBox(height: 30),
                  Text(product.description!),
                ],
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () async {
          await updateCart(1, id);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Product added to cart'),
            ),
          );
        },
        child: const Icon(Icons.add_shopping_cart),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
