import 'package:flutter/material.dart';

class KonversiSuhuPage extends StatefulWidget {
  const KonversiSuhuPage({super.key});

  @override
  State<KonversiSuhuPage> createState() => _KonversiSuhuPageState();
}

class _KonversiSuhuPageState extends State<KonversiSuhuPage> {
  final TextEditingController _inputController = TextEditingController();
  double _hasil = 0.0;
  String _satuanInput = 'Celsius';
  String _satuanOutput = 'Fahrenheit';

  final List<String> _satuanSuhu = ['Celsius', 'Fahrenheit', 'Kelvin'];

  void _konversiSuhu() {
    double input = double.tryParse(_inputController.text) ?? 0.0;

    if (_satuanInput == 'Celsius' && _satuanOutput == 'Fahrenheit') {
      _hasil = (input * 9 / 5) + 32;
    } else if (_satuanInput == 'Celsius' && _satuanOutput == 'Kelvin') {
      _hasil = input + 273.15;
    } else if (_satuanInput == 'Fahrenheit' && _satuanOutput == 'Celsius') {
      _hasil = (input - 32) * 5 / 9;
    } else if (_satuanInput == 'Fahrenheit' && _satuanOutput == 'Kelvin') {
      _hasil = (input - 32) * 5 / 9 + 273.15;
    } else if (_satuanInput == 'Kelvin' && _satuanOutput == 'Celsius') {
      _hasil = input - 273.15;
    } else if (_satuanInput == 'Kelvin' && _satuanOutput == 'Fahrenheit') {
      _hasil = (input - 273.15) * 9 / 5 + 32;
    } else {
      _hasil = input;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Konversi Suhu',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.teal,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.green.shade200, Colors.teal.shade100],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Input Card
                Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        TextField(
                          controller: _inputController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Masukkan suhu',
                            labelStyle: TextStyle(color: Colors.teal.shade700),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.teal.shade700),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                              child: DropdownButtonFormField<String>(
                                value: _satuanInput,
                                decoration: InputDecoration(
                                  labelText: 'Dari',
                                  labelStyle: TextStyle(color: Colors.teal.shade700),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                items: _satuanSuhu.map((String satuan) {
                                  return DropdownMenuItem(
                                    value: satuan,
                                    child: Text(satuan),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    _satuanInput = value!;
                                  });
                                },
                              ),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: DropdownButtonFormField<String>(
                                value: _satuanOutput,
                                decoration: InputDecoration(
                                  labelText: 'Ke',
                                  labelStyle: TextStyle(color: Colors.teal.shade700),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                items: _satuanSuhu.map((String satuan) {
                                  return DropdownMenuItem(
                                    value: satuan,
                                    child: Text(satuan),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    _satuanOutput = value!;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Convert Button
                ElevatedButton(
                  onPressed: _konversiSuhu,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 5,
                  ),
                  child: const Text(
                    'Konversi Suhu',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Result Card
                Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      gradient: LinearGradient(
                        colors: [Colors.teal.shade100, Colors.teal.shade200],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          'Hasil Konversi',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.teal,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          '${_hasil.toStringAsFixed(2)} $_satuanOutput',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.teal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}