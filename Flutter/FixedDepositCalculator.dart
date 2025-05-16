import 'package:flutter/material.dart';

void main() => runApp(FixedDepositCalculatorApp());

class FixedDepositCalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fixed Deposit Calculator',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: FixedDepositCalculator(),
    );
  }
}

class FixedDepositCalculator extends StatefulWidget {
  @override
  _FixedDepositCalculatorState createState() => _FixedDepositCalculatorState();
}

class _FixedDepositCalculatorState extends State<FixedDepositCalculator> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _principalController = TextEditingController();
  final TextEditingController _rateController = TextEditingController();
  final TextEditingController _yearsController = TextEditingController();

  double? _maturityAmount;
  double? _interestEarned;

  void _calculateFD() {
    if (_formKey.currentState!.validate()) {
      double principal = double.parse(_principalController.text);
      double rate = double.parse(_rateController.text);
      double years = double.parse(_yearsController.text);

      // Simple annual compounding
      double maturity = principal * (pow((1 + rate / 100), years));
      double interest = maturity - principal;

      setState(() {
        _maturityAmount = maturity;
        _interestEarned = interest;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Fixed Deposit Calculator')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _principalController,
                decoration: InputDecoration(labelText: 'Principal Amount (₹)'),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value == null || value.isEmpty ? 'Enter principal' : null,
              ),
              TextFormField(
                controller: _rateController,
                decoration: InputDecoration(labelText: 'Interest Rate (%)'),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value == null || value.isEmpty ? 'Enter rate' : null,
              ),
              TextFormField(
                controller: _yearsController,
                decoration: InputDecoration(labelText: 'Duration (years)'),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value == null || value.isEmpty ? 'Enter duration' : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _calculateFD,
                child: Text('Calculate'),
              ),
              SizedBox(height: 20),
              if (_maturityAmount != null && _interestEarned != null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Maturity Amount: ₹${_maturityAmount!.toStringAsFixed(2)}',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Interest Earned: ₹${_interestEarned!.toStringAsFixed(2)}',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'dart:math';