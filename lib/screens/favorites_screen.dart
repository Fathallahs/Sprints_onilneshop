import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_app/providers/product_provider.dart';
import 'package:flutter_app/screens/product_detail_screen.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final products = context.watch<ProductProvider>().products.where((p) => p.isFavorite).toList();
    return Scaffold(
      appBar: AppBar(title: const Text('Favorites')),
      body: products.isEmpty
          ? const Center(child: Text('No favorites yet'))
          : ListView.builder(
              itemCount: products.length,
              itemBuilder: (ctx, i) => ListTile(
                leading: CircleAvatar(backgroundImage: NetworkImage(products[i].imageUrl)),
                title: Text(products[i].title),
                subtitle: Text('4${products[i].price.toStringAsFixed(2)}'),
                onTap: () => Navigator.of(context).pushNamed(
                  ProductDetailScreen.routeName,
                  arguments: products[i].id,
                ),
              ),
            ),
    );
  }
}
