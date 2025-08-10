import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_app/providers/orders_provider.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ordersData = Provider.of<OrdersProvider>(context);
    final orders = ordersData.orders;
    return Scaffold(
      appBar: AppBar(title: const Text('Orders')),
      body: orders.isEmpty
          ? const Center(child: Text('No orders yet.'))
          : ListView.builder(
              itemCount: orders.length,
              itemBuilder: (ctx, i) => Card(
                margin: const EdgeInsets.all(10),
                child: ExpansionTile(
                  title: Text('4${orders[i].amount.toStringAsFixed(2)}'),
                  subtitle: Text(orders[i].dateTime.toLocal().toString()),
                  children: orders[i].products
                      .map((cp) => ListTile(
                            title: Text(cp.title),
                            trailing: Text('${cp.quantity} x 4${cp.price.toStringAsFixed(2)}'),
                          ))
                      .toList(),
                ),
              ),
            ),
    );
  }
}
