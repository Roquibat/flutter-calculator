import 'package:flutter/material.dart';
import 'package:expressions/expressions.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Roquibats Calculator',
      theme: ThemeData.dark(),
      home: const CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String expression = "";
  String result = "";

  void onButtonPressed(String value) {
    setState(() {
      if (value == "C") {
        expression = "";
        result = "";
      } else if (value == "=") {
        try {
          Expression exp = Expression.parse(expression);
          final evaluator = const ExpressionEvaluator();
          var evalResult = evaluator.eval(exp, {});
          result = "= $evalResult";
        } catch (e) {
          result = "Error";
        }
      } else {
        expression += value;
      }
    });
  }

  Widget buildButton(String label) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () => onButtonPressed(label),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(24),
          textStyle: const TextStyle(fontSize: 24),
        ),
        child: Text(label),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Roquibat's Calculator")),
      body: Column(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(expression, style: const TextStyle(fontSize: 32)),
                  Text(result, style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
          Column(
            children: [
              Row(children: [buildButton("7"), buildButton("8"), buildButton("9"), buildButton("/")]),
              Row(children: [buildButton("4"), buildButton("5"), buildButton("6"), buildButton("*")]),
              Row(children: [buildButton("1"), buildButton("2"), buildButton("3"), buildButton("-")]),
              Row(children: [buildButton("0"), buildButton("C"), buildButton("="), buildButton("+")]),
            ],
          ),
        ],
      ),
    );
  }
}