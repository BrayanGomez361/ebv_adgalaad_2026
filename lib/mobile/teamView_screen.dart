import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TeamViewScreen extends StatefulWidget {
  final int teamIndex;
  const TeamViewScreen({super.key, required this.teamIndex});

  @override
  State<TeamViewScreen> createState() => _TeamViewScreenState();
}

class _TeamViewScreenState extends State<TeamViewScreen> {

  String titulo = '';
  Color color = CupertinoColors.black;

  Map<String,String> equipoReclutasPixel = {
    'Norma España':'Miembro',
    'Diego España':'Miembro',
    'Norma España':'Miembro',
    'Norma España':'Miembro',
    'Norma España':'Miembro',
  };

  Map<String,String> equipoHeroesPowerUp = {
    'Norma España':'Miembro',
    'Norma España':'Miembro',
    'Norma España':'Miembro',
    'Norma España':'Miembro',
    'Norma España':'Miembro',
  };

  Map<String,String> equipoLeyendasDelReino = {
    'Norma España':'Miembro',
    'Norma España':'Miembro',
    'Norma España':'Miembro',
    'Norma España':'Miembro',
    'Norma España':'Miembro',
  };
  
  @override
  void initState() {
    super.initState();

    switch (widget.teamIndex) {
      case 1:
        titulo = 'Reclutas Pixel';
        color = CupertinoColors.activeGreen;
        break;
      case 2:
        titulo = 'Héroes Power-up';
        color = CupertinoColors.activeBlue;
        break;
      case 3:
        titulo = 'Leyendas del Reino';
        color = CupertinoColors.systemRed;
        break;
      default: {
        titulo = '';
        color = CupertinoColors.black;
      }
    }
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        backgroundColor: CupertinoColors.transparent,
        middle: Text('Info del grupo: $titulo'),
      ),
      body: Padding(
        padding: EdgeInsets.all(0.0),
        child: CustomScrollView(
          slivers: [

            infoGrupo(widget.teamIndex),

            infoParticipantes(widget.teamIndex),
              
          ],
        ),
      ),
    );
  }

  SliverToBoxAdapter infoGrupo(int grupoIndex) {
    Map<String, String> info = {};

    if(widget.teamIndex == 1) {
      info = equipoReclutasPixel;
    }
    if(widget.teamIndex == 2) {
      info = equipoHeroesPowerUp;
    }
    if(widget.teamIndex == 3) {
      info = equipoLeyendasDelReino;
    }


    return SliverToBoxAdapter(
          child: CupertinoListSection.insetGrouped(
            header: Text('Equipo'),
            children: 
            info.entries.map((entry) {
        return CupertinoListTile(
          leading: Icon(
            CupertinoIcons.info,
            size: 20,
            color: Colors.white70,
          ),
          leadingSize: 20,
          title: Text(
            entry.key,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: Text(
            entry.value,
            style: const TextStyle(
              color: Colors.white70,
            ),
          ),
        );
      }).toList(),
      /*
            
            [
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
            */
          ),
        );
  }
  /*
  SliverToBoxAdapter infoGrupo2() {
    return SliverToBoxAdapter(
            child: CupertinoListSection.insetGrouped(
              header: Text('Equipo'),
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
          );
  }

  SliverToBoxAdapter infoGrupo1() {
    return SliverToBoxAdapter(
              child: CupertinoListSection.insetGrouped(
                header: Text('Equipo'),
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
            );
  }
  */



  SliverToBoxAdapter infoParticipantes(int grupoIndex){
    Map<String, String> info = {};

    return SliverToBoxAdapter(
          child: CupertinoListSection.insetGrouped(
            header: Text('Tablero de jugadores'),
            children: 
              info.entries.map((entry) {
                return CupertinoListTile(
                  leading: Icon(
                    CupertinoIcons.info,
                    size: 20,
                    color: Colors.white70,
                  ),
                  leadingSize: 20,
                  title: Text(
                    entry.key,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: Text(
                    entry.value,
                    style: const TextStyle(
                      color: Colors.white70,
                    ),
                  ),
                );
              }).toList(),
          ),
      );
    
      
    
  }
}