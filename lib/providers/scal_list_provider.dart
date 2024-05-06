import 'package:flutter/material.dart';
import 'package:solution_qr/models/scan_model.dart';
import 'package:solution_qr/providers/db_provider.dart';

class ScanListProvider extends ChangeNotifier {
  List<ScanModel> scans = [];

  String tipoSeleccionado = 'http';

  Future<ScanModel> nuevoScan(String valor) async {
    final nuevoScan = ScanModel(valor: valor);
    // aqui se llama al metodo nuevoScan de la clase DBProvider
    // este metodo nos permite insertar un nuevo scan en la base de datos
    // y nos retorna el id del scan insertado
    final id = await DBProvider.db.nuevoScan(nuevoScan);

    // le asignamos el id de la base de datos al objeto nuevoScan
    nuevoScan.id = id;

    if (tipoSeleccionado == nuevoScan.tipo) {
      // agregamos el nuevo scan a la lista de scans de tipo ScanModel
      scans.add(nuevoScan);
      print(nuevoScan.valor);
      notifyListeners();
    }

    return nuevoScan;
  }

  Future cargarScans() async {
    final scansDB = await DBProvider.db.getTodosLosScans();
    scans = [...scansDB];
    notifyListeners();
  }

  Future cargarScansPorTipo(String tipo) async {
    final scansDB = await DBProvider.db.getScansPorTipo(tipo);
    scans = [...scansDB];
    tipoSeleccionado = tipo;
    notifyListeners();
  }

  Future borrarTodos() async {
    await DBProvider.db.deleteAllScans();
    scans = [];
    notifyListeners();
  }

  Future borrarScanPorId(int id) async {
    await DBProvider.db.deleteScan(id);
    // _scans.removeWhere((element) => element.id == id);
    // notifyListeners();
    // cargarScansPorTipo(tipoSeleccionado);
  }
}
