// reports_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/charts.dart';

class ReportsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reportes de Gastos'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Tendencia de Gastos',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12.0),
            ExpenseCharts(),
            // Puedes agregar más elementos o información relacionada con los reportes aquí.
          ],
        ),
      ),
    );
  }
}
