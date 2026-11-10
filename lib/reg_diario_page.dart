import 'package:ebv_ad_galaad_2026/login_pin_screen.dart';
import 'package:ebv_ad_galaad_2026/main.dart';
import 'package:ebv_ad_galaad_2026/proyector_screen.dart';
import 'package:ebv_ad_galaad_2026/providers/supabase_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

class RegistroDiarioScreen extends StatefulWidget {
  final Map<String, dynamic> profesor;
  const RegistroDiarioScreen({super.key, required this.profesor});

  @override
  State<RegistroDiarioScreen> createState() => _RegistroDiarioScreenState();
}

class _RegistroDiarioScreenState extends State<RegistroDiarioScreen> {
  DateTime _fechaSeleccionada = DateTime.now();

  // Función para registrar o desmarcar un logro diario
  Future<void> _togglePuntoDiario({
    required String ninoId,
    required String concepto,
    required int xp,
    required bool yaRegistrado,
    String? registroId,
  }) async {
    try {
      if (yaRegistrado && registroId != null) {
        // Si ya estaba marcado hoy y se desmarca, eliminamos el registro
        await supabase.from('registro_puntos').delete().eq('id', registroId);
      } else {
        // Si no estaba marcado, agregamos el nuevo registro para la fecha actual
        await supabase.from('registro_puntos').insert({
          'nino_id': ninoId,
          'profesor_id': widget.profesor['id'],
          'concepto': concepto,
          'xp_otorgados': xp,
          'created_at': _fechaSeleccionada.toIso8601String(),
        });
      }
      setState(() {}); // Recargar UI
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al actualizar: $e'), backgroundColor: Colors.red),
      );
    }
  }

  final List<Map<String, dynamic>> criteriosSupabase = [
  {'id': '1', 'concepto': 'Puntual', 'xp': 10},
  {'id': '2', 'concepto': 'Biblia', 'xp': 20},
  {'id': '3', 'concepto': 'Memoriza', 'xp': 30},
  {'id': '4', 'concepto': 'Participa', 'xp': 20},
  {'id': '5', 'concepto': 'Responde', 'xp': 10},
  {'id': '6', 'concepto': 'Ayuda', 'xp': 20},
  {'id': '7', 'concepto': 'Respeta y obedece', 'xp': 20},
  {'id': '8', 'concepto': 'Trae invitado', 'xp': 50},
];

  @override
  Widget build(BuildContext context) {
    // Definimos el rango del día seleccionado para filtrar en la consulta
    final inicioDia = DateTime(_fechaSeleccionada.year, _fechaSeleccionada.month, _fechaSeleccionada.day).toIso8601String();
    final finDia = DateTime(_fechaSeleccionada.year, _fechaSeleccionada.month, _fechaSeleccionada.day, 23, 59, 59).toIso8601String();
    
    return Scaffold(
      body: Container(
        padding: EdgeInsets.zero,
        
        decoration: const BoxDecoration(
          //border: Border(top: BorderSide.none),
          gradient: RadialGradient(
            center: Alignment.center,
            radius: 0.8,
            colors: [
              Color(0xFFE0F2FE), // Azul muy claro (centro)
              Color(0xFF3B82F6), // Azul intermedio
              Color(0xFF1D4ED8), // Azul más oscuro (bordes)
            ],
            stops: [0.0, 0.6, 1.0],
          ),
          
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 50),
          child: CustomScrollView(
            slivers: [

              
              CupertinoSliverNavigationBar(
                backgroundColor: CupertinoColors.transparent,
                leading: Text('Hola, ${widget.profesor['nombre']}', style: TextStyle(fontWeight: FontWeight.bold),),
                largeTitle: const Text('Escuela Bíblica de Vacaciones', style: TextStyle(fontWeight: FontWeight.normal),),
                trailing: PopupMenuButton<String>(

                  elevation: 4,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  onSelected: (String value) async {
                    switch (value) {
                      case 'proyector':
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const ProyectorScreen()),
                        );
                        break;
                      case 'refrescar':
                        setState(() {});
                        break;
                      case 'cerrar_sesion':
                        //context.read<SupabaseProvider>().logout();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => LoginPinScreen(),
                          ),
                        );
                        break;
                    }
                  },
                  icon: Icon(Icons.more_vert),
                  color: CupertinoColors.white,
                  itemBuilder: (context) => [

                    PopupMenuItem<String>(
                      value: 'proyector',
                      height: 32, // Reducimos la altura predeterminada (de 48 a 32)
                      padding: const EdgeInsets.symmetric(horizontal: 12), // Relleno compacto
                      child: const Row(
                        spacing: 8,
                        children: [
                          Icon(Icons.tv, color: Colors.blue, size: 18),
                          //SizedBox(width: 8),
                          Text(
                            'Ver Tablero Proyector',
                            style: TextStyle(fontSize: 13, color: Color(0xFF1E293B)),
                          ),
                        ],
                      ),
                    ),

                    PopupMenuItem<String>(
                      value: 'kid',
                      height: 32, // Reducimos la altura predeterminada (de 48 a 32)
                      padding: const EdgeInsets.symmetric(horizontal: 12), // Relleno compacto
                      child: Row(
                        spacing: 8,
                        children: [
                          
                          Icon(CupertinoIcons.game_controller,
                            color: CupertinoColors.black,
                            size: 22,
                          ),
                          /*
                          Image.asset(
                            'assets/img/ninos.jpeg',
                            height: 30,
                          ),
                          */
                          //SizedBox(width: 8),
                          Text(
                            'Agregar niño(a)',
                            style: TextStyle(fontSize: 13, color: Color(0xFF1E293B)),
                          ),
                        ],
                      ),
                    ),

                    PopupMenuItem<String>(
                      value: 'maestro',
                      height: 32, // Reducimos la altura predeterminada (de 48 a 32)
                      padding: const EdgeInsets.symmetric(horizontal: 12), // Relleno compacto
                      child: const Row(
                        spacing: 8,
                        children: [
                          Icon(Icons.person, color: Colors.blue, size: 22,),
                          //SizedBox(width: 8),
                          Text(
                            'Agregar maestro',
                            style: TextStyle(fontSize: 13, color: Color(0xFF1E293B)),
                          ),
                        ],
                      ),
                    ),

                    PopupMenuItem<String>(
                      value: 'teams',
                      height: 32, // Reducimos la altura predeterminada (de 48 a 32)
                      padding: const EdgeInsets.symmetric(horizontal: 12), // Relleno compacto
                      child: const Row(
                        spacing: 8,
                        children: [
                          Icon(Icons.person, color: Colors.blue, size: 22,),
                          //SizedBox(width: 8),
                          Text(
                            'Ver grupos',
                            style: TextStyle(fontSize: 13, color: Color(0xFF1E293B)),
                          ),
                        ],
                      ),
                    ),

                    PopupMenuItem<String>(
                      value: 'admin_maestros',
                      height: 32, // Reducimos la altura predeterminada (de 48 a 32)
                      padding: const EdgeInsets.symmetric(horizontal: 12), // Relleno compacto
                      child: const Row(
                        spacing: 8,
                        children: [
                          Icon(Icons.groups, color: Colors.blue, size: 22,),
                          //SizedBox(width: 8),
                          Text(
                            'Administrar usuarios',
                            style: TextStyle(fontSize: 13, color: Color(0xFF1E293B)),
                          ),
                        ],
                      ),
                    ),

                    

                    PopupMenuItem<String>(
                      value: 'cerrar_sesion',
                      height: 32, // Reducimos la altura
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: const Row(
                        children: [
                          Icon(Icons.logout, color: Colors.red, size: 22),
                          SizedBox(width: 8),
                          Text(
                            'Cerrar Sesión',
                            style: TextStyle(fontSize: 13, color: Colors.red),
                          ),
                        ],
                      ),
                    ),

                    

                    


                    


                  ]
                    
                  
                )
              ),
              
          
              SliverToBoxAdapter(
                child: Center(
                  
                  child: Padding(
                    padding: const EdgeInsets.only(top:8.0, bottom: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [

                        Text('Grupo A', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32, color: CupertinoColors.white),),

                        Image.asset(
                          'assets/img/LOGO.png',
                          width: MediaQuery.of(context).size.width * 0.3
                        ),

                        SizedBox(
                        width: 125,
                        child: CupertinoButton.tinted(
                          padding: EdgeInsets.all(8.0),
                          color: CupertinoColors.black,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            //spacing: 12,
                            children: [
                              Text(DateFormat('EEEE','es_ES').format(_fechaSeleccionada).toUpperCase()),
                              Text(DateFormat('d','es_ES').format(_fechaSeleccionada).toUpperCase(), style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),),
                              Text(DateFormat('MMMM','es_ES').format(_fechaSeleccionada).toUpperCase()),
                              //Text('Día ${_fechaSeleccionada.day}/${_fechaSeleccionada.month}', style: TextStyle(color: CupertinoColors.white),),
                              //const Icon(Icons.calendar_today, color: CupertinoColors.white),
                              
                            ],
                          ), 
                          onPressed: () async {
                            final picked = await showDatePicker(
                              context: context,
                              //locale: Locale('es','ES'),
                              initialDate: _fechaSeleccionada,
                              firstDate: DateTime(2026, 1, 1),
                              lastDate: DateTime(2026, 12, 31),
                            );
                            if (picked != null) setState(() => _fechaSeleccionada = picked);
                          },
                        ),
                      ),


                      ],
                    ),
                  )
                ),
              ),

              SliverToBoxAdapter(
                child: Center(
                  
                  child: Padding(
                    padding: const EdgeInsets.only(top:8.0, bottom: 16.0,),
                    child: Text(
                      'Participantes asignados',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                        color: CupertinoColors.white
                      ),
                    )
                  )
                ),
              ),
          
              



              





              SliverToBoxAdapter(
  child: FutureBuilder<List<Map<String, dynamic>>>(
    future: supabase.from('ninos').select('''
      *,
      registro_puntos(id, concepto, created_at)
    ''').order('nombre', ascending: true),
    builder: (context, snapshot) {
      if (!snapshot.hasData) {
        return const Center(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: CircularProgressIndicator(),
          ),
        );
      }

      final kids = snapshot.data!;
      

      return Column(
        children: kids.map((item) {
          final registros = (item['registro_puntos'] as List? ?? []).where((r) {
            final fecha = DateTime.parse(r['created_at']);
            return fecha.isAfter(DateTime.parse(inicioDia)) && 
                   fecha.isBefore(DateTime.parse(finDia));
          }).toList();

          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              // Fondo blanco semi-translúcido para combinar con el degradado azul
              color: Colors.white.withOpacity(0.88),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: Colors.white.withOpacity(0.5),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // CABECERA: Nombre del niño a la izquierda, Ícono de Medallas totalmente a la derecha
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Text(
                            '${item['nombre']}: ',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1E293B),
                            ),
                          ),
                          Text(
                            '${item['xp_totales'].toString()} XP',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                              color: Color(0xFF1E293B),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Ícono de insignias/medallas posicionado a la derecha
                    IconButton(
                      icon: const Icon(Icons.workspace_premium, color: Colors.amber, size: 28),
                      tooltip: 'Asignar Insignias Especiales',
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (_) => DialogoInsignias(
                            ninoId: item['id'],
                            ninoNombre: item['nombre'],
                          ),
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                // CRITERIOS EN ACTIONCHIP CON SCROLL HORIZONTAL
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: criteriosSupabase.map((criterio) {
                    final registro = registros.cast<Map<String, dynamic>?>().firstWhere(
                      (r) => r?['concepto'] == criterio['concepto'],
                      orElse: () => null,
                    );
                    final bool asignado = registro != null;
                    
                    return FilterChip(
                      selected: asignado,
                      label: Text(
                        '${criterio['concepto']} (+${criterio['xp']} XP)',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF334155),
                        ),
                      ),
                      backgroundColor: Colors.white,
                      elevation: 1,
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: const BorderSide(color: Color(0xFFE2E8F0)),
                      ),
                      selectedColor: CupertinoColors.activeBlue,
                      onSelected: (bool selected) async {
                        
                        await _togglePuntoDiario(
                          ninoId: item['id'],
                          concepto: criterio['concepto'],
                          xp: criterio['xp'],
                          yaRegistrado: asignado,
                          registroId: registro?['id'],
                        );
                      },
                    );
                  }).toList(),
                ),
              ],
            ),
          );
        }).toList(),
      );
    },
  ),
),
          
              //SliverList.separated(itemBuilder: itemBuilder, separatorBuilder: separatorBuilder)
              
            ],
          ),
        ),
      ),
      
    );
  }

  Widget _buildFilterChip(String ninoId, String concepto, int xp, List<dynamic> registrosDelDia) {
    final registro = registrosDelDia.cast<Map<String, dynamic>?>().firstWhere(
      (r) => r?['concepto'] == concepto,
      orElse: () => null,
    );
    final bool asignado = registro != null;

    return FilterChip(
      label: Text('$concepto (+$xp)'),
      selected: asignado,
      selectedColor: Colors.amber,
      checkmarkColor: Colors.black,
      labelStyle: TextStyle(color: asignado ? Colors.black : Colors.white, fontSize: 12),
      onSelected: (bool selected) {
        _togglePuntoDiario(
          ninoId: ninoId,
          concepto: concepto,
          xp: xp,
          yaRegistrado: asignado,
          registroId: registro?['id'],
        );
      },
    );
  }
}