// expense_list.dart
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/expense_model.dart';
import 'package:flutter_application_1/utils/database_helper.dart';

class ExpenseList extends StatelessWidget {
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

          return ListView.builder(
            itemCount: expenses.length,
            itemBuilder: (context, index) {
              Expense expense = Expense.fromMap(expenses[index]);
              return ListTile(
                title: Text(expense.title),
                subtitle: Text('${expense.amount} - ${expense.date.toLocal()}'),
              );
            },
          );
        }
      },
    );
  }
}
