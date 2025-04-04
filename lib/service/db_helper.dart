import 'package:employee_demo/model/employee.dart';
import 'package:employee_demo/utils/logger.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

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
    if (kIsWeb) {
      _database = await _initDatabaseWeb();
    } else {
      _database = await _initDatabaseMobile();
    }
    return _database!;
  }

  Future<Database> _initDatabaseWeb() async {
    sqfliteFfiInit();
    var databaseFactory = databaseFactoryFfiWeb;
    var db = await databaseFactory.openDatabase(inMemoryDatabasePath);
    await db.execute('''
      CREATE TABLE IF NOT EXISTS $employeeTable(id INTEGER PRIMARY KEY AUTOINCREMENT, 
       name TEXT, role TEXT, start_date TEXT, end_date TEXT)
        ''');
    return db;
  }

  Future<Database> _initDatabaseMobile() async {
    String path = join(await sqflite.getDatabasesPath(), 'employees.db');
    return await sqflite.openDatabase(
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
    final r = await db.update(employeeTable, employee.toMap(),
        where: 'id = ?', whereArgs: [employee.id]);
    return r;
  }

  Future<int> deleteEmployee(int? id) async {
    if (id == null || id < 0) {
      return -1;
    }
    final db = await database;
    final r = await db.delete(employeeTable, where: 'id = ?', whereArgs: [id]);
    return r;
  }

  Future<List<Employee>> getEmployees() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(employeeTable);
    final list = List.generate(maps.length, (i) {
      return Employee.fromMap(maps[i]);
    });
    return list;
  }
}
