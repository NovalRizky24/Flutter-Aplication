import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Untuk format currency

class DiskonPage extends StatefulWidget {
  const DiskonPage({super.key});

  @override
  _DiskonPageState createState() => _DiskonPageState();
}

class _DiskonPageState extends State<DiskonPage> {
  final TextEditingController _hargaController = TextEditingController();
  final TextEditingController _diskonController = TextEditingController();
  double? _hargaAwal;
  double? _diskonValue;
  double? _hargaAkhir;
  bool _isLoading = false; // Untuk menampilkan loading
  final currencyFormat = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp ',
    decimalDigits: 0,
  );

  void _hitungDiskon() {
    setState(() {
      _isLoading = true; // Menandakan loading dimulai
    });

    // Simulasi proses perhitungan
    Future.delayed(const Duration(seconds: 1), () {
      double harga = double.tryParse(_hargaController.text.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;
      double diskon = double.tryParse(_diskonController.text) ?? 0;

      setState(() {
        _hargaAwal = harga;
        _diskonValue = harga * (diskon / 100);
        _hargaAkhir = harga - _diskonValue!;
        _isLoading = false; // Menandakan loading selesai
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Kalkulator Diskon",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
          child: Stack(
            children: [
              // Background image / color
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.green.shade200, Colors.teal.shade100],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
              // Konten utama
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildInputCard(),
                      const SizedBox(height: 20),
                      _buildCalculateButton(),
                      const SizedBox(height: 20),
                      if (_hargaAkhir != null) _buildResultCard(),
                    ],
                  ),
                ),
              ),
              // Indikator loading jika sedang memproses
              if (_isLoading)
                Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.teal),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputCard() {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            _buildTextField(
              controller: _hargaController,
              label: "Harga Barang",
              hint: "Masukkan harga barang",
              icon: Icons.attach_money,
              prefix: "Rp ",
            ),
            const SizedBox(height: 20),
            _buildTextField(
              controller: _diskonController,
              label: "Persentase Diskon",
              hint: "Masukkan persentase diskon",
              icon: Icons.percent,
              suffix: "%",
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    String? prefix,
    String? suffix,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          prefixIcon: Icon(icon, color: Colors.teal),
          prefixText: prefix,
          suffixText: suffix,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.grey.shade100,
        ),
      ),
    );
  }

  Widget _buildCalculateButton() {
    return ElevatedButton(
      onPressed: _hitungDiskon,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.teal,
        padding: const EdgeInsets.symmetric(vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 5,
      ),
      child: const Text(
        "Hitung Diskon",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildResultCard() {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            _buildResultItem(
              "Harga Awal",
              _hargaAwal!,
              Colors.grey.shade700,
            ),
            const SizedBox(height: 15),
            _buildResultItem(
              "Potongan Diskon",
              _diskonValue!,
              Colors.red.shade400,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 15.0),
              child: Divider(thickness: 2),
            ),
            _buildResultItem(
              "Harga Akhir",
              _hargaAkhir!,
              Colors.green.shade600,
              isTotal: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultItem(String label, double value, Color color, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 20 : 16,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            color: color,
          ),
        ),
        Text(
          currencyFormat.format(value),
          style: TextStyle(
            fontSize: isTotal ? 20 : 16,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            color: color,
          ),
        ),
      ],
    );
  }
}
