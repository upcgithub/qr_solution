import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solution_qr/pages/home_page.dart';
import 'package:solution_qr/pages/mapa_page.dart';

import 'providers/scal_list_provider.dart';
import 'providers/ui_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UiProvider()),
        ChangeNotifierProvider(create: (context) => ScanListProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        showSemanticsDebugger: false,
        title: 'Solution Scan QR Code',
        initialRoute: 'home',
        routes: {
          'home': (context) => const HomePage(),
          'mapa': (context) => const MapaPage(),
        },
        theme: ThemeData.light().copyWith(
          colorScheme: const ColorScheme.light(
            primary: Colors.deepPurple,
          ),
          primaryColor: Colors.deepPurple,
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: Colors.deepPurple,
          ),
        ),
      ),
    );
  }
}
