import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class KonversiMataUangPage extends StatefulWidget {
  const KonversiMataUangPage({super.key});

  @override
  _KonversiMataUangPageState createState() => _KonversiMataUangPageState();
}

class _KonversiMataUangPageState extends State<KonversiMataUangPage> {
  final List<String> _currencies = ['USD', 'EUR', 'IDR', 'JPY', 'GBP'];

  String? _selectedCurrencyFrom = 'USD';  // Mata uang asal
  String? _selectedCurrencyTo = 'EUR';    // Mata uang tujuan

  double _conversionRate = 0.0;
  double _inputAmount = 0.0;
  double _convertedAmount = 0.0;

  Future<void> _fetchExchangeRates() async {
    final String apiKey = '7d866b863352b24bd780bfad';
    final Uri url = Uri.parse(
        'https://v6.exchangerate-api.com/v6/$apiKey/latest/$_selectedCurrencyFrom');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _conversionRate = data['conversion_rates'][_selectedCurrencyTo].toDouble();
          _convertedAmount = _inputAmount * _conversionRate;
        });
      } else {
        throw Exception('Failed to load exchange rates');
      }
    } catch (e) {
      print('Error fetching exchange rates: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchExchangeRates();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Konversi Mata Uang',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.teal,
        elevation: 0,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.green.shade200, Colors.teal.shade100],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 20),
                  Text(
                    'Konversi Mata Uang',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal,
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildCurrencyInputRow('Mata Uang Asal', _selectedCurrencyFrom!, (newValue) {
                    setState(() {
                      _selectedCurrencyFrom = newValue!;
                      _fetchExchangeRates();
                    });
                  }, _currencies),
                  const SizedBox(height: 20),
                  _buildCurrencyInputRow('Mata Uang Tujuan', _selectedCurrencyTo!, (newValue) {
                    setState(() {
                      _selectedCurrencyTo = newValue!;
                      _fetchExchangeRates();
                    });
                  }, _currencies),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCurrencyInputRow(String label, String currentCurrency, ValueChanged<String?> onChanged, List<String> currencies) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Dropdown untuk memilih mata uang
            DropdownButton<String>(
              value: currentCurrency,
              onChanged: onChanged,
              items: currencies.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            // Kolom input jumlah uang berada di sebelah kanan dropdown untuk mata uang asal
            if (label == 'Mata Uang Asal')
              SizedBox(
                width: 250, // Lebar kolom input diperbesar
                child: TextField(
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    setState(() {
                      _inputAmount = double.tryParse(value) ?? 0.0;
                      _convertedAmount = _inputAmount * _conversionRate;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Jumlah',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            // Kolom hasil konversi berada di sebelah kanan untuk mata uang tujuan
            if (label == 'Mata Uang Tujuan')
              SizedBox(
                width: 250, // Lebar kolom hasil konversi diperbesar
                child: Text(
                  _convertedAmount == 0.0
                      ? '0'
                      : _convertedAmount.toStringAsFixed(2),
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
