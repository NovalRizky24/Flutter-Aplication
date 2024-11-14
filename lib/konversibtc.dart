import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class KonversiBTCPage extends StatefulWidget {
  const KonversiBTCPage({super.key});

  @override
  _KonversiBTCPageState createState() => _KonversiBTCPageState();
}

class _KonversiBTCPageState extends State<KonversiBTCPage> {
  final TextEditingController _btcController = TextEditingController();
  double _btcToCurrencyRate = 0.0; // Harga Bitcoin dalam USD
  double _inputBTC = 0.0;
  double _convertedAmount = 0.0;

  Future<void> _fetchBTCPrice() async {
    final String apiUrl = 'https://api.coindesk.com/v1/bpi/currentprice/BTC.json'; // API untuk mendapatkan harga BTC
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _btcToCurrencyRate = data['bpi']['USD']['rate_float'];
          _convertedAmount = _inputBTC * _btcToCurrencyRate;
        });
      } else {
        throw Exception('Failed to load BTC price');
      }
    } catch (e) {
      print('Error fetching BTC price: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchBTCPrice();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Konversi Bitcoin'),
        backgroundColor: Colors.teal,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.green.shade200, Colors.teal.shade100],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              Center(
                child: Text(
                  'Konversi Bitcoin ke USD',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // Card untuk Input Jumlah BTC
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 8,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.currency_bitcoin, color: Colors.teal, size: 28),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextField(
                              controller: _btcController,
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                setState(() {
                                  _inputBTC = double.tryParse(value) ?? 0.0;
                                  _convertedAmount = _inputBTC * _btcToCurrencyRate;
                                });
                              },
                              decoration: InputDecoration(
                                labelText: 'Jumlah BTC',
                                labelStyle: TextStyle(color: Colors.teal),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // Card untuk Output Hasil Konversi
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 8,
                color: Colors.teal.shade50,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
                  child: Column(
                    children: [
                      const Text(
                        'Hasil Konversi',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.teal,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        _convertedAmount == 0.0
                            ? '0 USD'
                            : '\$${_convertedAmount.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Menampilkan harga BTC dalam USD
              Center(
                child: Text(
                  'Harga 1 BTC = \$${_btcToCurrencyRate.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
