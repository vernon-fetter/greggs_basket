import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/sausage_roll.dart';
import '../providers/basket_manager.dart';
import '../widgets/basket_summary.dart';

class SausageRollScreen extends StatelessWidget {
  // Sample Sausage Roll data, this could also be fetched from a JSON or API
  final SausageRoll sausageRoll = SausageRoll(
    articleCode: '1000446',
    shopCode: '1234',
    availableFrom: DateTime.parse('2020-12-30T00:00:00Z'),
    availableUntil: DateTime.parse('2045-05-13T23:59:59Z'),
    eatOutPrice: 1.05,
    eatInPrice: 1.15,
    articleName: 'Sausage Roll',
    internalDescription: 'Sausage Roll',
    customerDescription: 'The Nation’s favourite Sausage Roll.',
    imageUri: 'https://articles.greggs.co.uk/images/1000446.png?1623244287449',
    thumbnailUri:
        'https://articles.greggs.co.uk/images/1000446-thumb.png?1623244287450',
    dayParts: ['Breakfast', 'Lunch', 'Evening'],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Greggs Sausage Roll'),
      ),
      body: Column(
        children: [
          Image.network(sausageRoll.imageUri),
          SizedBox(height: 10),
          Text(
            sausageRoll.articleName,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(sausageRoll.customerDescription),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              Provider.of<BasketManager>(context, listen: false)
                  .addItem(sausageRoll);
            },
            child: Text(
                'Add to Basket (\$${sausageRoll.eatOutPrice.toStringAsFixed(2)})'),
          ),
          SizedBox(height: 20),
          Expanded(
            child: BasketSummary(),
          ),
        ],
      ),
    );
  }
}
