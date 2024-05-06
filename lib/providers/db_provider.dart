import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../models/scan_model.dart';

class DBProvider {
  static Database? _database;
  static final DBProvider db = DBProvider._();
  DBProvider._();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDB();

    return _database!;
  }

  Future<Database> initDB() async {
    // Path de donde almacenaremos la base de datos
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'ScansDB.db');
    print(path);

    // Crear base de datos
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute('''
          CREATE TABLE Scans(
            id INTEGER PRIMARY KEY,
            tipo TEXT,
            valor TEXT
          )
        ''');
    });
  }

  Future<int> nuevoScanRaw(ScanModel nuevoScan) async {
    final id = nuevoScan.id;
    final tipo = nuevoScan.tipo;
    final valor = nuevoScan.valor;

    // Verificar la base de datos
    final db = await database;
    final res = await db.rawInsert('''
      INSERT INTO Scans( id, tipo, valor )
        VALUES( $id, '$tipo', '$valor' )
    ''');

    return res;
  }

  Future<int> nuevoScan(ScanModel nuevoScan) async {
    // Verificar la base de datos
    final db = await database;
    // en caso no envies un id a la base de datos, se autoincrementara
    // esto pasa porque el id es un campo autoincrementable al ser la llave primaria
    final res = await db.insert('Scans', nuevoScan.toJson());
    print(res);
    return res;
  }

  Future<ScanModel?> getScanById(int id) async {
    final db = await database;
    // el metodo query busca en la tabla Scans el registro que tenga el id que le pasamos
    // si no encuentra nada, regresa un List vacio
    // si encuentra algo, regresa un List con el registro que encontro
    // el parametro whereArgs es un List con los valores que se usaran en el where
    final res = await db.query('Scans', where: 'id = ?', whereArgs: [id]);
    return res.isNotEmpty ? ScanModel.fromJson(res.first) : null;
  }

  Future<List<ScanModel>> getTodosLosScans() async {
    final db = await database;
    final res = await db.query('Scans');
    // si res no esta vacio, mapeamos cada registro a un ScanModel
    // y con el metodo toList() convertimos el Iterable a una List
    // para asi devolver una List de ScanModel
    // si res esta vacio, devolvemos una List vacia
    return res.isNotEmpty ? res.map((s) => ScanModel.fromJson(s)).toList() : [];
  }

  Future<List<ScanModel>> getScansPorTipo(String tipo) async {
    final db = await database;
    final res = await db.rawQuery('''
      SELECT * FROM Scans WHERE tipo = '$tipo'
    ''');
    return res.isNotEmpty ? res.map((s) => ScanModel.fromJson(s)).toList() : [];
  }

  Future<int> updateScan(ScanModel nuevoScan) async {
    final db = await database;
    // el metodo update actualiza un registro en la tabla Scans
    // recordar usar el where para especificar que registro se actualizara
    // o sino se actualizara toda la tabla
    final res = await db.update('Scans', nuevoScan.toJson(),
        where: 'id = ?', whereArgs: [nuevoScan.id]);
    return res;
  }

  Future<int> deleteScan(int id) async {
    final db = await database;
    // el metodo delete elimina un registro en la tabla Scans
    // recordar usar el where para especificar que registro se eliminara
    // o sino se eliminara todos los registros de la tabla
    final res = await db.delete('Scans', where: 'id = ?', whereArgs: [id]);
    return res;
  }

  Future<int> deleteAllScans() async {
    final db = await database;
    // el metodo delete elimina un registro en la tabla Scans
    // en este caso si eliminara todos los registros de la tabla porque no se especifica un where
    final res = await db.delete('Scans');
    return res;
  }
}
