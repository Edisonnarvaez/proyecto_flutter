// charts.dart
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_application_1/models/expense_model.dart';
import 'package:flutter_application_1/utils/database_helper.dart';

class ExpenseCharts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: DatabaseHelper().getExpenses(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error al cargar los datos');
        } else {
          List<Map<String, dynamic>> expenses = snapshot.data!;
          List<Expense> expenseList = expenses.map((expenseMap) => Expense.fromMap(expenseMap)).toList();

          return LineChart(
            LineChartData(
              titlesData: FlTitlesData(leftTitlesShowInterval: 1),
              borderData: FlBorderData(show: true),
              gridData: FlGridData(show: true),
              lineBarsData: [
                LineChartBarData(
                  spots: expenseList.map((expense) {
                    // Usando el índice como eje X y el monto del gasto como eje Y.
                    return FlSpot(expenseList.indexOf(expense).toDouble(), expense.amount);
                  }).toList(),
                  isCurved: true,
                  colors: [Colors.blue],
                  dotData: FlDotData(show: false),
                  belowBarData: BarAreaData(show: false),
                ),
              ],
              titlesInPercentage: true,
              titlesOnTop: true,
            ),
          );
        }
      },
    );
  }
}
