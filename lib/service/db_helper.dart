import 'package:employee_demo/model/employee.dart';
import 'package:employee_demo/utils/logger.dart';
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

  String employeeTable = "employees";

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
            "CREATE TABLE IF NOT EXISTS $employeeTable(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, role TEXT, start_date TEXT, end_date TEXT)");
      },
    );
  }

  Future<int> addEmployee(Employee employee) async {
    final db = await database;
    final result = await db
        .insert(employeeTable, employee.toMap(),
            conflictAlgorithm: ConflictAlgorithm.replace)
        .catchError((e) {
      Logger.instance.printError(e);
      return 0;
    });
    Logger.instance.printLog("addEmployee $result");
    return result;
  }

  Future<int> updateEmployee(Employee employee) async {
    final db = await database;
    return await db.update(employeeTable, employee.toMap(),
        where: 'id = ?', whereArgs: [employee.id]);
  }

  Future<int> deleteEmployee(int? id) async {
    if(id == null || id < 0){
      return -1;
    }
    final db = await database;
    return await db.delete(employeeTable, where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Employee>> getEmployees() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(employeeTable);
    final list =  List.generate(maps.length, (i) {
      return Employee.fromMap(maps[i]);
    });
    return list;
  }
}
