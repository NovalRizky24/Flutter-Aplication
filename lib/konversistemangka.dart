import 'package:flutter/material.dart';

class KonversiSistemAngkaPage extends StatefulWidget {
  const KonversiSistemAngkaPage({Key? key}) : super(key: key);

  @override
  _KonversiSistemAngkaPageState createState() => _KonversiSistemAngkaPageState();
}

class _KonversiSistemAngkaPageState extends State<KonversiSistemAngkaPage> {
  String? inputValue;
  String inputBase = 'Desimal';
  String outputBase = 'Biner';
  String result = '';

  final TextEditingController inputController = TextEditingController();
  final TextEditingController resultController = TextEditingController();

  @override
  void dispose() {
    inputController.dispose();
    resultController.dispose();
    super.dispose();
  }

  void convert() {
    if (inputValue == null || inputValue!.isEmpty) return;

    try {
      int? decimalValue;

      // Convert input based on the input base
      if (inputBase == 'Desimal') {
        decimalValue = int.tryParse(inputValue!);
      } else if (inputBase == 'Biner') {
        decimalValue = int.tryParse(inputValue!, radix: 2);
      } else if (inputBase == 'Oktal') {
        decimalValue = int.tryParse(inputValue!, radix: 8);
      } else if (inputBase == 'Heksadesimal') {
        decimalValue = int.tryParse(inputValue!, radix: 16);
      }

      if (decimalValue == null) {
        setState(() {
          result = 'Input tidak valid';
        });
        return;
      }

      // Convert to the selected output base
      if (outputBase == 'Desimal') {
        result = decimalValue.toString();
      } else if (outputBase == 'Biner') {
        result = decimalValue.toRadixString(2);
      } else if (outputBase == 'Oktal') {
        result = decimalValue.toRadixString(8);
      } else if (outputBase == 'Heksadesimal') {
        result = decimalValue.toRadixString(16);
      }

      setState(() {
        resultController.text = result; // Set result in TextField
      });
    } catch (e) {
      setState(() {
        result = 'Terjadi kesalahan: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Konversi Sistem Angka'),
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
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildInputSection(),
                const SizedBox(height: 20),
                _buildOutputSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputSection() {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: _boxDecoration(),
      child: Row(
        children: [
          _buildDropdown(inputBase, (String? newValue) {
            setState(() {
              inputBase = newValue!;
            });
            convert(); // Trigger the conversion when the base changes
          }),
          const SizedBox(width: 15),
          Expanded(
            child: TextField(
              controller: inputController,
              decoration: const InputDecoration(
                labelText: 'Masukkan Angka',
                prefixIcon: Icon(Icons.input),
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                inputValue = value;
                convert(); // Trigger the conversion when the input changes
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOutputSection() {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: _boxDecoration(),
      child: Row(
        children: [
          _buildDropdown(outputBase, (String? newValue) {
            setState(() {
              outputBase = newValue!;
            });
            convert(); // Trigger the conversion when the base changes
          }),
          const SizedBox(width: 15),
          Expanded(
            child: TextField(
              controller: resultController,
              decoration: const InputDecoration(
                labelText: 'Hasil',
                prefixIcon: Icon(Icons.calculate),
                border: OutlineInputBorder(),
              ),
              readOnly: true,
            ),
          ),
        ],
      ),
    );
  }

  DropdownButton<String> _buildDropdown(String value, ValueChanged<String?> onChanged) {
    return DropdownButton<String>(
      value: value,
      items: ['Desimal', 'Biner', 'Oktal', 'Heksadesimal']
          .map((base) => DropdownMenuItem(value: base, child: Text(base)))
          .toList(),
      onChanged: onChanged,
      dropdownColor: Colors.white,
      icon: const Icon(Icons.arrow_drop_down, color: Colors.teal),
      underline: Container(),
      style: const TextStyle(color: Colors.black87, fontSize: 16),
    );
  }

  BoxDecoration _boxDecoration() {
    return BoxDecoration(
      color: Colors.white.withOpacity(0.9),
      borderRadius: BorderRadius.circular(15),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 10,
          spreadRadius: 2,
        ),
      ],
    );
  }
}
