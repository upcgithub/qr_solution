import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solution_qr/pages/directions_page.dart';
import 'package:solution_qr/providers/scal_list_provider.dart';
import 'package:solution_qr/widgets/custom_navigator_bar.dart';
import 'package:solution_qr/widgets/scan_button.dart';

import '../providers/ui_provider.dart';
import 'mapas_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Historial'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              final scanListProvider =
                  Provider.of<ScanListProvider>(context, listen: false);
              scanListProvider.borrarTodos();
            },
          )
        ],
      ),
      body: const _HomePageBody(),
      bottomNavigationBar: const CustomNavigationBar(),
      floatingActionButton: const ScanButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class _HomePageBody extends StatelessWidget {
  const _HomePageBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // cuando instanciamos un Provider en un widget, este widget se suscribe a los cambios de la clase Provider
    // es por eso que cuando hacemos el llamado del set selectedMenuOpt(int i) en el CustomNavigationBar se actualiza la interfaz
    final uiProvider = Provider.of<UiProvider>(context);
    // aqui solo accedes a una propiedad de la clase UiProvider
    // en este punto aun no se ha implementado la funcionalidad de cambiar de pagina
    // se necesita usar el metodo ser selectedMenuOpt(int i) que tiene el notifyListeners() para cambiar de pagina
    final currentIndex = uiProvider.selectedMenuOpt;

    // temporal leer la base de datos
    // final tempScan = new ScanModel(valor: 'http://fernando-herrera.com');
    // DBProvider.db.nuevoScan(tempScan);

    // Usar el ScanListProvider
    // en este caso la propiedad listen es false porque no necesitamos escuchar los cambios en este widget
    // sino en los widgets hijos, que en este caso son MapasPage y DirectionsPage
    final scanListProvider =
        Provider.of<ScanListProvider>(context, listen: false);

    switch (currentIndex) {
      case 0:
        // cargar los scans de tipo geo
        scanListProvider.cargarScansPorTipo('geo');
        return const MapasPage();
      case 1:
        // cargar los scans de tipo http
        scanListProvider.cargarScansPorTipo('http');
        return DirectionsPage();
      default:
        return const MapasPage();
    }
  }
}
