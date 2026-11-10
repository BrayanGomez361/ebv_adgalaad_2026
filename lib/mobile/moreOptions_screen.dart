import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MoreOptionsScreen extends StatefulWidget {
  const MoreOptionsScreen({super.key});

  @override
  State<MoreOptionsScreen> createState() => _MoreOptionsScreenState();
}

class _MoreOptionsScreenState extends State<MoreOptionsScreen> {

  double fontSizeLarge = 24.0;
  double fontSize = 14.0;
  double fontSmall = 12.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsetsGeometry.all(0),
        child: CustomScrollView(
          slivers: [

            CupertinoSliverNavigationBar(
              backgroundColor: CupertinoColors.transparent,
              largeTitle: Text('Más opciones',),
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: [


                    CupertinoButton.tinted(
                      child: Column(
                        children: [
                          Icon(CupertinoIcons.person_add),
                          Text('Agregar\n jugador', textAlign: TextAlign.center, style: TextStyle(fontSize: fontSize),)
                        ],
                      ), 
                        onPressed: (){}
                    ),

                    CupertinoButton.tinted(
                      child: Column(
                        children: [
                          Icon(CupertinoIcons.person_add),
                          Text('Agregar\nVoluntario', textAlign: TextAlign.center, style: TextStyle(fontSize: fontSize))
                        ],
                      ), 
                        onPressed: (){

                          String _rolSeleccionado = 'Maestro';
                          final List<String> _roles = ['Maestro', 'Auxiliar', 'Logística'];

                          showDialog(
                            context: context,
                            builder: (context) {
                              return StatefulBuilder(
                                builder: (context, setStateModal) {
                                  return Dialog(
                                    backgroundColor: Colors.transparent, // Mantiene el estilo limpio
                                    child: ConstrainedBox(
                                      constraints: const BoxConstraints(
                                        maxWidth: 400, // 👈 Ajusta el ancho máximo deseado en píxeles
                                        
                                      ),
                                      child: IntrinsicHeight(
                                        child: CupertinoListSection.insetGrouped(
                                          header: const Text(
                                            'Agregar voluntario',
                                            style: TextStyle(color: Colors.white70),
                                          ),
                                          footer: Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              CupertinoButton(
                                                child: const Text('Cancelar'),
                                                onPressed: () => Navigator.pop(context),
                                              ),
                                              CupertinoButton.tinted(
                                                child: const Text('Agregar'),
                                                onPressed: () {
                                                  // Guardar voluntario con _rolSeleccionado
                                                  Navigator.pop(context);
                                                },
                                              ),
                                            ],
                                          ),
                                          children: [
                                            // Campo para el nombre
                                            CupertinoTextFormFieldRow(
                                              prefix: Icon(CupertinoIcons.person, color: Colors.white70),
                                              placeholder: 'Nombre del voluntario',
                                              placeholderStyle: TextStyle(color: Colors.white38),
                                              style: TextStyle(color: Colors.white),
                                            ),
                                        
                                            // SELECTOR DESPLEGABLE ESTILO CUPERTINO
                                            CupertinoListTile(
                                              leading: const Icon(CupertinoIcons.person_3, color: Colors.white70),
                                              title: const Text(
                                                'Grupo asignado',
                                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                                              ),
                                              trailing: PopupMenuButton<String>(
                                                initialValue: _rolSeleccionado,
                                                tooltip: 'Seleccionar rol',
                                                onSelected: (String nuevoRol) {
                                                  setStateModal(() {
                                                    _rolSeleccionado = nuevoRol;
                                                  });
                                                },
                                                // Botón que activa el menú estilo iOS
                                                child: Row(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    Text(
                                                      _rolSeleccionado,
                                                      style: const TextStyle(
                                                        color: Color.fromARGB(255, 109, 167, 220),
                                                        fontSize: 15,
                                                        fontWeight: FontWeight.w500,
                                                      ),
                                                    ),
                                                    const SizedBox(width: 4),
                                                    const Icon(
                                                      CupertinoIcons.chevron_up_chevron_down,
                                                      size: 14,
                                                      color: Color.fromARGB(255, 109, 167, 220),
                                                    ),
                                                  ],
                                                ),
                                                itemBuilder: (BuildContext context) {
                                                  return _roles.map((String rol) {
                                                    return PopupMenuItem<String>(
                                                      value: rol,
                                                      child: Row(
                                                        children: [
                                                          if (rol == _rolSeleccionado)
                                                            const Icon(CupertinoIcons.check_mark, size: 16, color: Colors.blue)
                                                          else
                                                            const SizedBox(width: 16),
                                                          const SizedBox(width: 8),
                                                          Text(rol),
                                                        ],
                                                      ),
                                                    );
                                                  }).toList();
                                                },
                                              ),
                                            ),
                                        
                                            CupertinoTextFormFieldRow(
                                              prefix: Icon(CupertinoIcons.person, color: Colors.white70),
                                              placeholder: 'Clave de acceso',
                                              placeholderStyle: TextStyle(color: Colors.white38),
                                              style: TextStyle(color: Colors.white),
                                            ),
                                        
                                        
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          );

                        }
                    ),


                    CupertinoButton.tinted(
                      child: Column(
                        children: [
                          Icon(CupertinoIcons.person_add),
                          Text('Buscar\n jugador', textAlign: TextAlign.center, style: TextStyle(fontSize: fontSize) )
                        ],
                      ), 
                        onPressed: (){}
                    ),

                    CupertinoButton.tinted(
                      child: Column(
                        children: [
                          Icon(CupertinoIcons.person_add),
                          Text('Buscar\n maestro', textAlign: TextAlign.center, style: TextStyle(fontSize: fontSize))
                        ],
                      ), 
                        onPressed: (){}
                    ),

                    CupertinoButton.tinted(
                      child: Column(
                        //crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(CupertinoIcons.person_add),
                          Text('Ver\nTablero', textAlign: TextAlign.center, style: TextStyle(fontSize: fontSize))
                        ],
                      ), 
                        onPressed: (){}
                    ),

                    CupertinoButton.tinted(
                      child: Column(
                        //crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(CupertinoIcons.person_add),
                          Text('Ver\nInsignias', textAlign: TextAlign.center, style: TextStyle(fontSize: fontSize))
                        ],
                      ), 
                        onPressed: (){}
                    ),






                  ],
                ),
              ),
            )

          ],
        ),
      ),
    );
  }
}