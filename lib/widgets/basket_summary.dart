import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/basket_manager.dart';

class BasketSummary extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final basketManager = Provider.of<BasketManager>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Basket:',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: basketManager.items.length,
            itemBuilder: (context, index) {
              final item = basketManager.items[index];
              return ListTile(
                title: Text(item.articleName),
                subtitle: Text('Price: \$${item.eatOutPrice.toStringAsFixed(2)}'),
              );
            },
          ),
        ),
        Divider(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Total: \$${basketManager.totalPrice.toStringAsFixed(2)}',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
