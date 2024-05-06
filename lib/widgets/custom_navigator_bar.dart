import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/ui_provider.dart';

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // cuando instanciamos un Provider en un widget, este widget se suscribe a los cambios de la clase Provider
    final uiProvider = Provider.of<UiProvider>(context);
    final currentIndex = uiProvider.selectedMenuOpt;

    return BottomNavigationBar(
      // aqui estamos usando el metodo set selectedMenuOpt(int i) para cambiar el valor de la propiedad _selectedMenuOpt
      // y este set a su vez ejecuta el notifyListeners() que actualiza la interfaz de todas las paginas que esten escuchando a este provider
      onTap: (value) => uiProvider.selectedMenuOpt = value,
      currentIndex: currentIndex,
      elevation: 1,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.map),
          label: 'Mapa',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.compass_calibration),
          label: 'Direcciones',
        ),
      ],
    );
  }
}
