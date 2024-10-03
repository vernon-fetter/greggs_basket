import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/sausage_roll.dart';
import '../providers/basket_manager.dart';
import '../widgets/basket_summary.dart';

class SausageRollScreen extends StatefulWidget {
  @override
  _SausageRollScreenState createState() => _SausageRollScreenState();
}

class _SausageRollScreenState extends State<SausageRollScreen> {
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

  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    final basketManager = Provider.of<BasketManager>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Greggs Sausage Roll'),
        actions: [
          Switch(
            value: basketManager.isEatIn,
            onChanged: (value) {
              basketManager.toggleEatIn();
            },
            activeColor: Colors.white,
          ),
          Text(basketManager.isEatIn ? 'Eat In' : 'Take Out'),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          if (quantity > 1) quantity--;
                        });
                      },
                      icon: Icon(Icons.remove),
                    ),
                    Text('$quantity'),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          quantity++;
                        });
                      },
                      icon: Icon(Icons.add),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    basketManager.addItem(sausageRoll, quantity);
                  },
                  child: Text(
                    'Add to Basket (\$${(basketManager.isEatIn ? sausageRoll.eatInPrice : sausageRoll.eatOutPrice) * quantity})',
                  ),
                ),
                SizedBox(height: 20),
                // Use Expanded to allow ListView to take up remaining space
                SizedBox(
                  height: MediaQuery.of(context).size.height *
                      0.5, // Limiting the height to half of the screen
                  child: BasketSummary(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
