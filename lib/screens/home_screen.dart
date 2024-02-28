// home_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/expense_form.dart';
import 'package:flutter_application_1/components/expense_list.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Control de Gastos'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ExpenseForm(),
          Divider(), // Opcional: agregar un separador entre el formulario y la lista.
          Expanded(
            child: ExpenseList(),
          ),
        ],
      ),
    );
  }
}
