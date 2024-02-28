// expense_form.dart
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/expense_model.dart';
import 'package:flutter_application_1/utils/database_helper.dart';

class ExpenseForm extends StatefulWidget {
  @override
  _ExpenseFormState createState() => _ExpenseFormState();
}

class _ExpenseFormState extends State<ExpenseForm> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  void _submitExpense() async {
    final String title = _titleController.text;
    final double amount = double.tryParse(_amountController.text) ?? 0.0;

    if (title.isNotEmpty && amount > 0) {
      Expense newExpense = Expense(
        title: title,
        amount: amount,
        date: _selectedDate,
      );

      DatabaseHelper().insertExpense(newExpense.toMap());

      // Puedes añadir más lógica aquí, como actualizar la lista de gastos en la interfaz de usuario.

      // Limpia los controladores después de enviar el gasto.
      _titleController.clear();
      _amountController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: _titleController,
            decoration: InputDecoration(labelText: 'Concepto del Gasto'),
          ),
          SizedBox(height: 12.0),
          TextField(
            controller: _amountController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: 'Monto'),
          ),
          SizedBox(height: 12.0),
          Row(
            children: [
              Text('Fecha: ${_selectedDate.toLocal().toString().split(' ')[0]}'),
              SizedBox(width: 8.0),
              ElevatedButton(
                onPressed: () => _selectDate(context),
                child: Text('Seleccionar Fecha'),
              ),
            ],
          ),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: _submitExpense,
            child: Text('Registrar Gasto'),
          ),
        ],
      ),
    );
  }
}
