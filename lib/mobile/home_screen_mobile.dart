import 'package:ebv_ad_galaad_2026/theme/theme_color.dart';
import 'package:ebv_ad_galaad_2026/widgets/category_chip.dart';
import 'package:ebv_ad_galaad_2026/widgets/customCheckbox.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Categoria {
  final String id;
  final String nombre;
  final IconData icono;
  final int xp;
  const Categoria(this.id, this.nombre, this.icono, this.xp);
}

const List<Categoria> _categorias = [
  Categoria('puntual', 'Puntual', Icons.access_time, 10),
  Categoria('biblia', 'Biblia', Icons.menu_book, 10),
  Categoria('memoriza', 'Memoriza', Icons.psychology, 20),
  Categoria('participa', 'Participa', Icons.lightbulb_outline, 20),
  Categoria('ayuda', 'Ayuda', Icons.volunteer_activism, 10),
  Categoria('responde', 'Responde', Icons.chat_bubble_outline, 20),
  Categoria('respeta', 'Respeta y obedece', Icons.back_hand_outlined, 20),
  Categoria('invitado', 'Trae invitado', Icons.person_add_alt, 20),
];

class HomeScreenPageMobileView extends StatefulWidget {
  const HomeScreenPageMobileView({super.key});

  @override
  State<HomeScreenPageMobileView> createState() =>
      _HomeScreenPageMobileViewState();
}

class _HomeScreenPageMobileViewState extends State<HomeScreenPageMobileView> {
  final TextEditingController _nameController = TextEditingController();

  double fontSizeLarge = 24.0;
  double fontSize = 14.0;
  double fontSmall = 12.0;

  // Luego esto vendrá de tu base de datos / modelo
  final List<String> _ninos = [
    'Miguel Ángel Torres',
    'Sofía Ramírez',
    'Daniel Castro',
    'Maerie Sanha',
    'Pavica Martin',
    'Miguel Ángel Torres',
    'Sofía Ramírez',
    'Daniel Castro',
    'Maerie Sanha',
    'Pavica Martin',
    'Miguel Ángel Torres',
    'Sofía Ramírez',
    'Daniel Castro',
    'Maerie Sanha',
    'Pavica Martin',
  ];

  String _categoriaSeleccionada = _categorias.first.id;

  // categoría -> niños marcados
  final Map<String, Set<String>> _marcados = {
    for (final c in _categorias) c.id: <String>{},
  };

  Set<String> get _marcadosActual => _marcados[_categoriaSeleccionada]!;

  bool get _todosMarcados => _marcadosActual.length == _ninos.length;

  void _toggleNino(String nino) {
    setState(() {
      _marcadosActual.contains(nino)
          ? _marcadosActual.remove(nino)
          : _marcadosActual.add(nino);
    });
  }

  void _toggleTodos() {
    setState(() {
      if (_todosMarcados) {
        _marcadosActual.clear();
      } else {
        _marcadosActual.addAll(_ninos);
      }
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    final categoriaActual =
        _categorias.firstWhere((c) => c.id == _categoriaSeleccionada);

    return Scaffold(
      //backgroundColor: CupertinoColors.secondarySystemFill,
      appBar: CupertinoNavigationBar(
        backgroundColor: CupertinoColors.activeGreen,
        middle: Text('Reclutas Pixel'),

      ),

      
      
      body: Padding(
        padding: const EdgeInsets.all(0),
        
        
        child: CustomScrollView(
          slivers: [
            
            
            // 1. Fecha del día
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0, top: 0.0, right: 16.0),
                child: CupertinoListTile(
                  leading: Icon(CupertinoIcons.calendar_today,
                    color: CupertinoColors.white,
                  ),
                  title: Text('Fecha del día',
                    style: TextStyle(
                      fontSize: fontSize,
                    ),
                  ),
                  trailing: Text(
                    DateFormat('EEEE dd','es_ES').format(DateTime.now()),
                    style: TextStyle(
                      color: CupertinoColors.activeBlue,
                      fontSize: fontSize,
                    ),
                  ),

                  onTap: () {
                    
                  },
                ),
              ),
            ),



            // 2. Selección de la categoría a calificar
             SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0, top: 8.0, right: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Categorías para calificar:',
                      style: TextStyle(
                        fontSize: fontSize,
                        fontWeight: FontWeight.normal,
                        letterSpacing: -0.41,
                        color: Colors.white
                      ),
                    ),
                    
                  ],
                ),
              ),
             ),



            SliverToBoxAdapter(
              child: SizedBox(
                height: 48,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: _categorias.length,
                  itemBuilder: (context, index) {
                    final cat = _categorias[index];
                    final isSelected = _categoriaSeleccionada == cat.id;

                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: 
                      //CategoryChip(label: cat.nombre, icon: cat.icono, isSelected: isSelected, onTap: (){setState(() => _categoriaSeleccionada = cat.id);})
                      /*
                      FilterChip(
                        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
                        showCheckmark: false,
                        avatar: Icon(
                          cat.icono,
                          size: 18,
                          color: isSelected ? Color.fromARGB(255, 109, 167, 220) : Color.fromARGB(255, 195, 194, 183),
                        ),
                        label: Text(
                          cat.nombre,
                          style: TextStyle(
                            fontSize: 14,
                            color: isSelected ? Color.fromARGB(255, 109, 167, 220): Color.fromARGB(255, 195, 194, 183),
                            fontWeight:
                                isSelected ? FontWeight.w500 : FontWeight.normal,
                          ),
                        ),
                        selected: isSelected,
                        selectedColor: Color.fromARGB(255, 3, 32, 66),
                        backgroundColor: CupertinoColors.black,

                        onSelected: (_) {
                          setState(() => _categoriaSeleccionada = cat.id);
                        },
                      ),
                      */

                      FilterChip(
                        showCheckmark: false,
                        avatar: Icon(
                          cat.icono,
                          size: 18,
                          color:  Colors.white,
                        ),
                        label: Text(
                          cat.nombre,
                          style: TextStyle(
                            color:  Colors.white,
                            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                            fontSize: fontSize,
                          ),
                        ),
                        selected: isSelected,
                        selectedColor: Color.fromARGB(255, 3, 32, 66),
                        backgroundColor: Colors.black,

                        // Borde del mismo color que el relleno cuando está seleccionado
                        side: BorderSide(
                          color: isSelected ? Color.fromARGB(255, 3, 32, 66) : Colors.black,
                          width: 0,
                        ),

                        // Evita que Material 3 mezcle un tinte sobre el relleno
                        surfaceTintColor: Colors.transparent,
                        elevation: 0,
                        pressElevation: 0,

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        onSelected: (_) {
                          setState(() => _categoriaSeleccionada = cat.id);
                        },
                      ),
                      
                    );
                  },
                ),
              ),
            ),

            




          // 3. Mostrar la categoría actual
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0, top: 8.0, right: 16.0, bottom: 8.0),
                child: Row(
                  spacing: 8.0,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [

                        Expanded(
                          child: Text(
                            'Categoría seleccionada',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: fontSize,
                              fontWeight: FontWeight.normal,
                              letterSpacing: -0.41,
                              color: Colors.white
                            ),
                          ),
                        ),

                        Icon(CupertinoIcons.chevron_right, size: fontSize,),

                        Text(
                          categoriaActual.nombre,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: fontSizeLarge,
                            fontWeight: FontWeight.bold,
                            letterSpacing: -0.41,
                            color: Colors.white
                          ),
                        ),

                        Icon(CupertinoIcons.chevron_right, size: fontSize,),
                        /* '+${categoriaActual.xp} XP por niño\n'
                            '${_marcadosActual.length} de ${_ninos.length} marcados', */
                        Expanded(
                          child: Text(
                            '+${categoriaActual.xp} XP por niño',
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: fontSmall, 
                              color: Colors.white,

                            ),
                          ),
                        ),
                
                    

                
                
                
                  ],
                ),
              ),
            ),



            // Resumen + marcar a todos
            SliverToBoxAdapter(
              child: Padding(
                padding:
                    const EdgeInsets.only(left:16.0, right: 16.0, top: 0, bottom: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    
                    
                    CupertinoButton(
                      padding: EdgeInsets.all(4.0),
                      minSize: 0,
                      onPressed: _toggleTodos,
                      child: Text(
                        _todosMarcados ? 'Quitar a todos' : 'Marcar a todos',
                        style: TextStyle(fontSize: fontSize, color: Colors.blueAccent, fontWeight: FontWeight.normal),
                      ),
                    ),
                  ],
                ),
              ),
            ),
SliverToBoxAdapter(
  child: Padding(
    padding: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
    child: Row(
      // Alinea los elementos verticalmente al centro
      crossAxisAlignment: CrossAxisAlignment.center, 
      children: [
        // 1. Expanded hace que la columna ocupe todo el espacio sobrante
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Lista de jugadores del reino',
                maxLines: 1, // 👈 Evita que salte a una segunda línea
                softWrap: false, // 👈 Desactiva el ajuste automático de línea
                overflow: TextOverflow.fade,
                style: TextStyle(
                  fontSize: fontSizeLarge,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.41,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                'Marca a quienes cumplieron con este criterio.',
                maxLines: 1, // 👈 Evita que salte a una segunda línea
                softWrap: false, // 👈 Desactiva el ajuste automático de línea
                overflow: TextOverflow.fade,
                style: TextStyle(
                  fontSize: fontSmall,
                  fontWeight: FontWeight.normal,
                  letterSpacing: -0.2,
                  height: 1.2,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(width: 16), // Separación fija entre textos y botón

        // 2. El botón SIN Expanded mantiene su tamaño original intacto
        CupertinoButton.tinted(
          padding: const EdgeInsets.all(12), // Relleno compacto e independiente
          onPressed: () {},
          child: const Icon(CupertinoIcons.person_add),
        ),
      ],
    ),
  ),
),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 16.0, right:16.0, top: 8.0, bottom: 8.0),
                child: CupertinoTextField(
                  controller: _nameController,
                  prefix: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Icon(
                      CupertinoIcons.search,
                      color: CupertinoColors.white,
                      size: fontSize,
                    ),
                  ),

                  decoration: BoxDecoration(
                    border: Border.all(
                      color: CupertinoColors.systemGrey,
                      width: 0.3
                    ),
                    borderRadius: BorderRadius.circular(25.0)
                  ),

                  clearButtonMode: OverlayVisibilityMode.editing,

                  placeholder: 'Buscar por nombre',
                ),
              )
              
            ),

            // Lista de niños
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(left: 0.0, right: 0.0, top:8.0, bottom: 150.0),
                child: CupertinoListSection(
                  topMargin: 0,
                  backgroundColor: CupertinoColors.transparent,
                  children: [
                    for (int i = 0; i < _ninos.length; i++) ...[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0.0),
                        child: CupertinoListTile(
                          // Usas el elemento actual y su índice 'i'
                          leading: Text('${i+1}'),
                          title: Text(
                            _ninos[i], // Ejemplo: "1. Carlos"
                            style: TextStyle(fontSize: fontSize),
                          ),
                          trailing: CustomCheckbox(
                            value: _marcadosActual.contains(_ninos[i]),
                            onChanged: null,
                          ),
                          onTap: () => _toggleNino(_ninos[i]),
                        ),
                      ),
                    ]
                  ],
                ),
              ),
            ),


            
          ],
        ),
      ),
    );
  }
}