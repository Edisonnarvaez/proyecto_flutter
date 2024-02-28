// expense_model.dart
class Expense {
  String title;
  double amount;
  DateTime date;

  Expense({required this.title, required this.amount, required this.date});

  // Método para convertir el objeto Expense a un mapa (para almacenamiento en la base de datos).
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'amount': amount,
      'date': date.toIso8601String(), // Convierte la fecha a una cadena ISO 8601.
    };
  }

  // Constructor alternativo para crear un objeto Expense a partir de un mapa.
  factory Expense.fromMap(Map<String, dynamic> map) {
    return Expense(
      title: map['title'],
      amount: map['amount'],
      date: DateTime.parse(map['date']),
    );
  }
}
