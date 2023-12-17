import 'package:flutter/material.dart';

void main() => runApp(HitungBelanjaApp());

class HitungBelanjaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hitung Belanja',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HitungBelanjaScreen(),
    );
  }
}

class HitungBelanjaScreen extends StatefulWidget {
  @override
  _HitungBelanjaScreenState createState() => _HitungBelanjaScreenState();
}

class _HitungBelanjaScreenState extends State<HitungBelanjaScreen> {
  TextEditingController _controllerHarga = TextEditingController();
  TextEditingController _controllerJumlah = TextEditingController();
  int _jumlahBarang = 0;
  double _totalHarga = 0.0;
  double _diskon = 0.0;

  void _hitungTotalHarga() {
    setState(() {
      try {
        double harga = double.parse(_controllerHarga.text);
        int jumlah = int.parse(_controllerJumlah.text);

        _jumlahBarang = jumlah;
        _totalHarga = harga * jumlah;

        //diskom
        if (jumlah > 2) {
          _diskon = 0.1 * _totalHarga;
          _totalHarga -= _diskon;
        } else {
          _diskon = 0.0;
        }
      } catch (e) {
        _jumlahBarang = 0;
        _totalHarga = 0.0;
        _diskon = 0.0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kasir Sederhana'),
        
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _controllerHarga,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Harga Barang (per barang)',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _controllerJumlah,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Jumlah Barang',
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _hitungTotalHarga,
              child: Text('Proses'),
            ),
            SizedBox(height: 20.0),
            Text(
              'Jumlah Barang: $_jumlahBarang',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Total Harga Yang Harus Di Bayar: \R\p\.$_totalHarga',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Diskon: \R\p\.$_diskon',
               style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
