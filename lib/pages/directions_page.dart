import 'package:flutter/material.dart';
import 'package:solution_qr/widgets/scan_tiles.dart';

class DirectionsPage extends StatelessWidget {
  const DirectionsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ScanTiles(tipo: 'http');
  }
}
