import 'package:ebv_ad_galaad_2026/mobile/teamView_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class RecursosScreen extends StatefulWidget {
  const RecursosScreen({super.key});

  @override
  State<RecursosScreen> createState() => _RecursosScreenState();
}

class _RecursosScreenState extends State<RecursosScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: CupertinoNavigationBar (
        backgroundColor: CupertinoColors.transparent,
        middle: Text('Información general'),

      ),
      
      body: Padding(
        padding: EdgeInsetsGeometry.fromLTRB(0, 0, 0, 16),
        child: CustomScrollView(
          slivers: [

            SliverToBoxAdapter(
              child: CupertinoListSection.insetGrouped(
                header: Text('Escuela Bíblica de Vacaciones'),
                children: [
                  CupertinoListTile(
                    leading: Icon(CupertinoIcons.info, size: 20,),
                    leadingSize: 20,
                    title: Text(
                      'Nombre'
                    ),
                    subtitle: Text('Power On'),
                  ),

                  CupertinoListTile(
                    leading: Icon(CupertinoIcons.info, size: 20,),
                    leadingSize: 20,
                    title: Text(
                      'Lema'
                    ),
                    subtitle: Text('Subiendo de nivel con Jesús'),
                  ),

                  CupertinoListTile(
                    leading: Icon(CupertinoIcons.info, size: 20,),
                    leadingSize: 20,
                    title: Text(
                      'Versículo clave'
                    ),
                    subtitle: Text('Todo lo puedo en Cristo que me fortalece. Fil. 4:13'),
                  ),

                  CupertinoListTile(
                    leading: Icon(CupertinoIcons.info, size: 20,),
                    leadingSize: 20,
                    title: Text(
                      'Propósito'
                    ),
                    subtitle: Text('Evangelístico'),
                  ),
                ],
              ),
            ),

            SliverToBoxAdapter(
              child: CupertinoListSection.insetGrouped(
                header: Text('Grupos de jugadores'),
                children: [
                  CupertinoListTile(
                    leading: Icon(CupertinoIcons.gamecontroller, size: 20,),
                    leadingSize: 20,
                    title: Text(
                      'Reclutas Pixel'
                    ),
                    subtitle: Text(
                      '3 a 4 años'
                    ),
                    trailing: const CupertinoListTileChevron(),
                    onTap: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => TeamViewScreen(teamIndex: 1,),
                        ),
                      );
                    },
                  ),

                  CupertinoListTile(
                    leading: Icon(CupertinoIcons.gamecontroller, size: 20,),
                    leadingSize: 20,
                    title: Text(
                      'Héroes Power-up'
                    ),
                    subtitle: Text(
                      '3 a 4 años'
                    ),
                    trailing: const CupertinoListTileChevron(),
                    onTap: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => TeamViewScreen(teamIndex: 2,),
                        ),
                      );
                    },
                  ),

                  CupertinoListTile(
                    leading: Icon(CupertinoIcons.gamecontroller, size: 20,),
                    leadingSize: 20,
                    title: Text(
                      'Leyendas del Reino'
                    ),
                    subtitle: Text(
                      '3 a 4 años'
                    ),
                    trailing: const CupertinoListTileChevron(),
                    onTap: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => TeamViewScreen(teamIndex: 3,),
                        ),
                      );
                    },
                  ),
                ],
              ),
            )


          ],
        ),
      ),

    );
  }
}