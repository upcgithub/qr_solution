import 'package:flutter/material.dart';
import 'package:solution_qr/models/scan_model.dart';
import 'package:url_launcher/url_launcher.dart';

Future launchUrlUtil(BuildContext context, ScanModel scan) async {
  if (scan.tipo == 'http') {
    try {
      await launchUrl(
        Uri.parse(scan.valor),
        mode: LaunchMode.inAppWebView,
      );
    } catch (e) {
      print('*************');
      print(e.toString());
      print('*************');
      throw 'Could not launch ${scan.valor}';
    }
  } else {
    Navigator.pushNamed(context, 'mapa', arguments: scan);
  }
}
