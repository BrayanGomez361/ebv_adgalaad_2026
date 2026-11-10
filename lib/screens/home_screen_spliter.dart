import 'package:ebv_ad_galaad_2026/mobile/home_screen_mobile.dart';
import 'package:ebv_ad_galaad_2026/mobile/moreOptions_screen.dart';
import 'package:ebv_ad_galaad_2026/mobile/programView_screen.dart';
import 'package:ebv_ad_galaad_2026/reg_diario_page.dart';
import 'package:ebv_ad_galaad_2026/screens/recursos_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class HomeScreenSpliterView extends StatelessWidget {
  final Map<String, dynamic> profesor;
  const HomeScreenSpliterView({super.key, required this.profesor});

  @override
  Widget build(BuildContext context) {
    final double anchoPantalla = MediaQuery.of(context).size.width;
    /*
    if (anchoPantalla < 600) {
      return const HomeScreenPageMobileView();
    }
    else {
      return RegistroDiarioScreen(profesor: profesor);
    }
    */

    return  MainCupertinoTabPage(profesor: profesor,);
    
  }
}

class MainCupertinoTabPage extends StatefulWidget {
  final Map<String, dynamic> profesor;
  const MainCupertinoTabPage({super.key, required this.profesor});

  @override
  State<MainCupertinoTabPage> createState() => _MainCupertinoTabPageState();
}

class _MainCupertinoTabPageState extends State<MainCupertinoTabPage> {
  int _currentIndex = 0;
  
  final List<GlobalKey<NavigatorState>> _navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

  Widget _buildTabNavigator(int index, Widget rootPage) {
    return Navigator(
      key: _navigatorKeys[index],
      onGenerateRoute: (routeSettings) {
        return CupertinoPageRoute(
          builder: (context) => rootPage,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        activeColor: CupertinoColors.white,
        
        items: const [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.gamecontroller),  // Asignar puntos(encargado), los demás solo ver
            label: 'Registro diario',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.list_bullet), // Ver programación completa por día
            label: 'Programa',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.folder_open), // Enlaces para coreografías, ver su grupo
            label: 'Info',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.ellipsis), // Cerrar Sesión
            label: 'Más',
          ),
        ],
      ),
      tabBuilder: (context, index) {
        switch (index) {
          case 0:
            return _buildTabNavigator(0, HomeScreenPageMobileView());
          case 1:
            return _buildTabNavigator(1, ProgramViewScreen());
          case 2:
            return _buildTabNavigator(2, RecursosScreen());
          case 3:
            return _buildTabNavigator(3, MoreOptionsScreen());
          default:
            return _buildTabNavigator(0, const Center(child: Text('Registro diario')));
        }
      },
    );
  
  }
}