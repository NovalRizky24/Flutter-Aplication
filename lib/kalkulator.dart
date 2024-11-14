import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class KalkulatorPage extends StatefulWidget {
  const KalkulatorPage({super.key});

  @override
  State<KalkulatorPage> createState() => _KalkulatorPageState();
}

class _KalkulatorPageState extends State<KalkulatorPage> {
  String display = "";
  List<String> history = [];

  void onPressed(String text) {
    setState(() {
      if (display == "Error") display = "";
      if (display.isEmpty && text == ".") return; // Tidak boleh titik pertama
      display += text;
    });
  }

  void clear() {
    setState(() {
      display = "";
    });
  }

  void delete() {
    setState(() {
      if (display.isNotEmpty) {
        display = display.substring(0, display.length - 1);
      }
    });
  }

  void calculate() {
    setState(() {
      try {
        // Menggunakan library math_expressions untuk evaluasi ekspresi
        Parser parser = Parser();
        Expression expression = parser.parse(display.replaceAll('×', '*').replaceAll('÷', '/'));
        double result = expression.evaluate(EvaluationType.REAL, ContextModel());

        String formattedResult = result.toString();
        if (formattedResult.endsWith(".0")) {
          formattedResult = formattedResult.substring(0, formattedResult.length - 2);
        }

        // Menyimpan ke history
        history.insert(0, "$display = $formattedResult");
        if (history.length > 5) history.removeLast();

        display = formattedResult;
      } catch (e) {
        display = "Error";
      }
    });
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.green.shade200, Colors.teal.shade100],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildHeader(context),
              const Spacer(), // Menambahkan spacer di atas untuk mendorong widget ke bawah
              _buildHistory(), // History sekarang di bawah
              _buildDisplay(), // Display berada di atas keypad
              const SizedBox(height: 10), // Tambahkan jarak antara display dan keypad
              _buildKeypad(),
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.teal),
            onPressed: () => Navigator.pop(context),
          ),
          const Text(
            'Kalkulator',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.teal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDisplay() {
    return Container(
      width: double.infinity,
      height: 100,
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Text(
        display,
        style: const TextStyle(
          fontSize: 48,
          fontWeight: FontWeight.bold,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.right,
      ),
    );
  }

  Widget _buildHistory() {
    return Container(
      height: 100,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.5),
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListView.builder(
        itemCount: history.length,
        reverse: true,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: Text(
              history[index],
              style: TextStyle(
                color: Colors.teal.shade700,
                fontSize: 16,
              ),
              textAlign: TextAlign.right,
            ),
          );
        },
      ),
    );
  }

  Widget _buildKeypad() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              _buildButton("C", color: Colors.red.shade400),
              _buildButton("⌫", color: Colors.orange.shade400),
              _buildButton("%", color: Colors.teal),
              _buildButton("÷", color: Colors.teal),
            ],
          ),
          Row(
            children: [
              _buildButton("7"),
              _buildButton("8"),
              _buildButton("9"),
              _buildButton("×", color: Colors.teal),
            ],
          ),
          Row(
            children: [
              _buildButton("4"),
              _buildButton("5"),
              _buildButton("6"),
              _buildButton("-", color: Colors.teal),
            ],
          ),
          Row(
            children: [
              _buildButton("1"),
              _buildButton("2"),
              _buildButton("3"),
              _buildButton("+", color: Colors.teal),
            ],
          ),
          Row(
            children: [
              _buildButton("0", flex: 2),
              _buildButton("."),
              _buildButton("=", color: Colors.green.shade600),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String text, {Color? color, int flex = 1}) {
    return Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Material(
          color: color ?? Colors.white,
          borderRadius: BorderRadius.circular(15),
          elevation: 2,
          child: InkWell(
            onTap: () {
              if (text == "C") {
                clear();
              } else if (text == "⌫") {
                delete();
              } else if (text == "=") {
                calculate();
              } else {
                onPressed(text);
              }
            },
            borderRadius: BorderRadius.circular(15),
            child: Container(
              height: 65,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: color == null ? Colors.teal.shade700 : Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
