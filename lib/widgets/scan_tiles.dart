import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:solution_qr/providers/scal_list_provider.dart';
import 'package:solution_qr/utils/utils.dart';

class ScanTiles extends StatelessWidget {
  final String tipo;

  const ScanTiles({Key? key, required this.tipo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scanListProvider = Provider.of<ScanListProvider>(context);
    final scans = scanListProvider.scans;

    return ListView.builder(
      itemCount: scans.length,
      itemBuilder: (BuildContext context, int index) {
        return Dismissible(
          key: UniqueKey(),
          background: Container(
            color: Colors.red,
          ),
          onDismissed: (direction) {
            Provider.of<ScanListProvider>(context, listen: false)
                .borrarScanPorId(scans[index].id!);
          },
          child: ListTile(
            title: Text(scans[index].valor),
            subtitle: Text(scans[index].id.toString()),
            leading: Icon(
              tipo == 'http' ? Icons.location_on : Icons.explore,
              color: Colors.deepPurple,
            ),
            trailing: const Icon(Icons.keyboard_arrow_right),
            onTap: () {
              launchUrlUtil(context, scans[index]);
            },
          ),
        );
      },
    );
  }
}
