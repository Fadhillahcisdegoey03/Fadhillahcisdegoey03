import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Cashier App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CashierApp(),
    );
  }
}

class CashierApp extends StatefulWidget {
  @override
  _CashierAppState createState() => _CashierAppState();
}

class _CashierAppState extends State<CashierApp> {
  List<Item> _itemsInCart = [];
  List<Item> _availableItems = [
    Item(name: 'Sepeda', price: 100000.0),
    Item(name: 'Motor', price: 15000000.0),
    Item(name: 'Mobil', price: 200000000.0),
    // Add more items as needed
  ];

  void _addItemToCart(Item item, int quantity) {
    setState(() {
      Item existingItem = _itemsInCart.firstWhere((element) => element.name == item.name, orElse: () => Item(name: '', price: 0.0));
      if (existingItem.name.isNotEmpty) {
        existingItem.quantity += quantity;
      } else {
        _itemsInCart.add(Item(name: item.name, price: item.price, quantity: quantity));
      }
    });
  }

  void _completePayment() {
    double totalAmount = 0.0;
    _itemsInCart.forEach((item) {
      totalAmount += item.price * item.quantity;
    });

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Pembayaran Total'),
          content: Text('Jumlah Total: \R\p${totalAmount.toStringAsFixed(2)}'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _resetCart();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _resetCart() {
    setState(() {
      _itemsInCart.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fadhillah Kasir'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _availableItems.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_availableItems[index].name),
                  subtitle: Text('\R\p${_availableItems[index].price.toStringAsFixed(2)}'),
                  trailing: ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          int quantity = 1;
                          return AlertDialog(
                            title: Text('tambahkam'),
                            content: Column(
                              children: [
                                Text('Masukan Jumlah:'),
                                TextField(
                                  keyboardType: TextInputType.number,
                                  onChanged: (value) {
                                    quantity = int.tryParse(value) ?? 1;
                                  },
                                ),
                              ],
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('batal'),
                              ),
                              TextButton(
                                onPressed: () {
                                  _addItemToCart(_availableItems[index], quantity);
                                  Navigator.of(context).pop();
                                },
                                child: Text('tambah'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Text('Masukan Ke Keranjang'),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _itemsInCart.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_itemsInCart[index].name),
                  subtitle: Text(
                    '\R\p${(_itemsInCart[index].price * _itemsInCart[index].quantity).toStringAsFixed(2)}',
                  ),
                  trailing: Text('Jumlah: ${_itemsInCart[index].quantity}'),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: _itemsInCart.isNotEmpty ? _completePayment : null,
            child: Text('Pembayaran Berhasil'),
          ),
        ],
      ),
    );
  }
}

class Item {
  final String name;
  final double price;
  int quantity;

  Item({required this.name, required this.price, this.quantity = 1});
