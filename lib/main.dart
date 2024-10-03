import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/basket_manager.dart';
import 'screens/sausage_roll_screen.dart';
import 'services/storage_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BasketManager(StorageService()),
      child: MaterialApp(
        title: 'Greggs Sausage Roll Basket',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        home: SausageRollScreen(),
      ),
    );
  }
}
