import 'package:employee_demo/model/employee.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() {
    return _instance;
  }

  static DatabaseHelper get instance => _instance;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'employees.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
            "CREATE TABLE IF NOT EXISTS employees(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, role TEXT, start_date TEXT, end_date TEXT)");
      },
    );
  }

  Future<int> addEmployee(Employee employee) async {
    final db = await database;
    return await db.insert('employees', employee.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<int> updateEmployee(Employee employee) async {
    final db = await database;
    return await db.update('employees', employee.toMap(),
        where: 'id = ?', whereArgs: [employee.id]);
  }

  Future<int> deleteEmployee(int id) async {
    final db = await database;
    return await db.delete('employees', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Employee>> getEmployees() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('employees');
    return List.generate(maps.length, (i) {
      return Employee.fromMap(maps[i]);
    });
  }
}
