// database_helper.dart
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static DatabaseHelper? _instance;
  late Database _database;

  factory DatabaseHelper() {
    if (_instance == null) {
      _instance = DatabaseHelper._internal();
    }
    return _instance!;
  }

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database;

    // Si _database es null, inicializa la base de datos.
    _database = await initDatabase();
    return _database;
  }

  Future<Database> initDatabase() async {
    // Obtiene la ruta del directorio de documentos del usuario.
    String path = join(await getDatabasesPath(), 'expenses_database.db');

    // Abre la base de datos. Si no existe, se crea una nueva.
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        // Crea la tabla para almacenar los gastos.
        await db.execute('''
          CREATE TABLE expenses(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            amount REAL,
            date TEXT
          )
        ''');
      },
    );
  }

  Future<void> insertExpense(Map<String, dynamic> expenseMap) async {
    final Database db = await database;

    // Inserta el gasto en la tabla.
    await db.insert('expenses', expenseMap);
  }

  Future<List<Map<String, dynamic>>> getExpenses() async {
    final Database db = await database;

    // Obtiene todos los gastos de la tabla.
    return await db.query('expenses');
  }

  // Otros métodos para realizar operaciones CRUD (Actualizar, Eliminar) según sea necesario.
}
