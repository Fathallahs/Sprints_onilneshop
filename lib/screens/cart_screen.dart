import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_app/providers/cart_provider.dart';
import 'package:flutter_app/providers/orders_provider.dart';
import 'package:flutter_app/l10n/app_localizations.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';

  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    final localizations = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.yourCartTitle),
      ),
      body: Column(
        children: <Widget>[
          Card(
            margin: const EdgeInsets.all(15),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    localizations.totalText,
                    style: const TextStyle(fontSize: 20),
                  ),
                  const Spacer(),
                  Chip(
                    label: Text(
                      '\$${cart.totalAmount.toStringAsFixed(2)}',
                      style: TextStyle(
                        color: Theme.of(context).primaryTextTheme.titleLarge?.color,
                      ),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  TextButton(
                    onPressed: cart.items.isEmpty
                        ? null
                        : () {
                            // Create order, then clear cart
                            Provider.of<OrdersProvider>(context, listen: false)
                                .addOrder(cart.items.values.toList(), cart.totalAmount);
                            cart.clearCart();
                          },
                    child: Text(localizations.orderNowButton),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: cart.items.length,
              itemBuilder: (ctx, i) => Dismissible(
                key: ValueKey(cart.items.values.toList()[i].id),
                background: Container(
                  color: Theme.of(context).colorScheme.error,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 20),
                  margin: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 4,
                  ),
                  child: const Icon(
                    Icons.delete,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
                direction: DismissDirection.endToStart,
                onDismissed: (direction) {
                  cart.removeItem(cart.items.keys.toList()[i]);
                },
                child: Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 4,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: FittedBox(
                            child: Text('\$${cart.items.values.toList()[i].price}'),
                          ),
                        ),
                      ),
                      title: Text(cart.items.values.toList()[i].title),
                      subtitle: Text(
                          'Total: \$${(cart.items.values.toList()[i].price * cart.items.values.toList()[i].quantity).toStringAsFixed(2)}'),
                      trailing: SizedBox(
                        width: 120,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove_circle_outline),
                              onPressed: () => cart.decreaseQuantity(cart.items.keys.toList()[i]),
                            ),
                            Text('${cart.items.values.toList()[i].quantity}x'),
                            IconButton(
                              icon: const Icon(Icons.add_circle_outline),
                              onPressed: () => cart.increaseQuantity(cart.items.keys.toList()[i]),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
