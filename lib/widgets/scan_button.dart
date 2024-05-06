import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';
import 'package:solution_qr/utils/utils.dart';

import '../providers/scal_list_provider.dart';

class ScanButton extends StatelessWidget {
  const ScanButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 0,
      child: const Icon(
        Icons.filter_center_focus,
        color: Colors.white,
      ),
      onPressed: () async {
        debugPrint('Scan QR');
        String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#3D8BEF',
          'Cancelar',
          false,
          ScanMode.QR,
        );

        // final barcodeScanRes = 'geo:-12.0877932,-77.0492285';
        // final barcodeScanRes = 'https://fernando-herrera.com/';
        if (barcodeScanRes == '-1') {
          return;
        }
        // obtenemos la referencia de la instancia del provider ScanListProvider
        // y llamamos al metodo nuevoScan que nos permite agregar un nuevo scan a la base de datos
        // ademas el metodo notifyListeners() actualiza la interfaz de los widgets que esten escuchando a este provider
        // en este caso no necesitamos escuchar los cambios en este widget es por eso que el listen es false
        final scanListProvider =
            Provider.of<ScanListProvider>(context, listen: false);
        final nuevoScan = await scanListProvider.nuevoScan(barcodeScanRes);

        launchUrlUtil(context, nuevoScan);
      },
    );
  }
}
