import 'dart:ui';

import 'package:ebv_ad_galaad_2026/proyector_screen.dart';
import 'package:ebv_ad_galaad_2026/screens/loginPin_screen.dart';
import 'package:ebv_ad_galaad_2026/theme/theme_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'login_pin_screen.dart';
import 'providers/supabase_provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://wkngnhnwuijrpingjybv.supabase.co',
    anonKey: 'sb_publishable_dAJ1tPRr1oZKxIwp4uxT3Q_Da_Z5oIY',
  );

  await initializeDateFormatting ('es', null); // O 'es_ES'

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SupabaseProvider()),
      ],
      child: const GameOnApp(),
    ),
  );
}


final supabase = Supabase.instance.client;
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class AppScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}

class GameOnApp extends StatelessWidget {
  const GameOnApp({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(

      navigatorKey: navigatorKey,
      supportedLocales: const [
        Locale('es', 'ES'),
        Locale('en', 'US'),
      ],
      title: 'Game On - EBDV',
      debugShowCheckedModeBanner: false,
      
      home: const MobileLoginPinScreen(),
      //theme: MyAppTheme.lightTheme,
      theme: MyAppTheme.cupertinoLightTheme,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      builder: (context, child) {
        return ScrollConfiguration (
          behavior: AppScrollBehavior (),
          child: child ?? const SizedBox.shrink(),
        );
      },
    );
    /*
    MaterialApp(
      locale: const Locale('es', 'ES'),
      scrollBehavior: AppScrollBehavior(),
      

      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      
      title: 'Game On - EBDV',
      debugShowCheckedModeBanner: false,
      theme: MyAppTheme.lightTheme,
      home: const MobileLoginPinScreen(),
    );
    */
  }
}


/*
class _LoginPinScreenState extends State<LoginPinScreen> {
  final TextEditingController _pinController = TextEditingController();
  bool _loading = false;

  Future<void> _login() async {
    setState(() => _loading = true);
    final pin = _pinController.text.trim();

    try {
      final response = await supabase
          .from('profesores')
          .select()
          .eq('pin', pin)
          .maybeSingle();

      if (response != null) {
  if (!mounted) return;
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (_) => RegistroDiarioScreen(profesor: response),
    ),
  );
} else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('PIN incorrecto. Inténtalo de nuevo.')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al conectar: $e')),
      );
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          constraints: BoxConstraints(
            maxWidth: 400,
          ),
          
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.sports_esports, size: 80, color: Colors.amber),
              const SizedBox(height: 16),
              const Text(
                'GAME ON',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.amber),
              ),
              const Text('Sistema de Puntuación Escuela Bíblica de Vacaciones', style: TextStyle(color: Colors.grey)),
              const SizedBox(height: 32),
              TextField(
                controller: _pinController,
                keyboardType: TextInputType.number,
                obscureText: true,
                maxLength: 6,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 24, letterSpacing: 8),
                decoration: const InputDecoration(
                  labelText: 'Ingresa tu PIN',
                  border: OutlineInputBorder(),
                  counterText: '',
                ),
              ),
              const SizedBox(height: 20),
              _loading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber,
                        minimumSize: const Size.fromHeight(50),
                      ),
                      onPressed: _login,
                      child: const Text('INGRESAR', style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const ProyectorScreen()),
                  );
                },
                child: const Text('Abrir Modo Proyector / Tablero', style: TextStyle(color: Colors.cyan)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
*/


// -----------------------------------------------------------------------------
// 2. DASHBOARD DEL PROFESOR (REGISTRO RÁPIDO DE PUNTOS POR NIÑO)
// -----------------------------------------------------------------------------
class ProfesorDashboardScreen extends StatelessWidget {
  final Map<String, dynamic> profesor;
  const ProfesorDashboardScreen({super.key, required this.profesor});

  // Método para otorgar puntos rápidamente
  Future<void> _sumarXP(BuildContext context, String ninoId, String concepto, int xp) async {
  try {
    await context.read<SupabaseProvider>().sumarXP(
      ninoId: ninoId,
      concepto: concepto,
      xp: xp,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('+$xp XP otorgados por: $concepto'),
        duration: const Duration(seconds: 1),
        backgroundColor: Colors.green,
      ),
    );
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error al guardar: $e'), backgroundColor: Colors.red),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Maestro: ${profesor['nombre']}'),
        actions: [
          IconButton(
            icon: const Icon(Icons.tv),
            tooltip: 'Ver Tablero Proyector',
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ProyectorScreen())),
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginPinScreen())),
          ),
        ],
      ),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: context.read<SupabaseProvider>().client
          .from('ninos')
          .stream(primaryKey: ['id'])
          .eq('profesor_id', profesor['id'])
          .order('nombre'),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
          final ninos = snapshot.data!;

          if (ninos.isEmpty) {
            return const Center(child: Text('No tienes niños asignados a tu grupo.'));
          }

          return ListView.builder(
            itemCount: ninos.length,
            itemBuilder: (context, index) {
              final nino = ninos[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            nino['nombre'],
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.amber.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.amber),
                            ),
                            child: Text(
                              '${nino['xp_totales']} XP • ${nino['nivel_actual']}',
                              style: const TextStyle(color: Colors.amber, fontWeight: FontWeight.bold),
                            ),
                          ),
                          IconButton(
              icon: const Icon(Icons.workspace_premium, color: Colors.amber),
              tooltip: 'Asignar Insignias Especiales',
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) => DialogoInsignias(
                    ninoId: nino['id'],
                    ninoNombre: nino['nombre'],
                  ),
                );
              },
            ),
                        ],
                      ),
                      const Divider(height: 20),
                      const Text('Botones Rápido de Puntuación:', style: TextStyle(fontSize: 12, color: Colors.grey)),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          _botontPuntos(context, nino['id'], 'Puntualidad', 10), //[cite: 1]
                          _botontPuntos(context, nino['id'], 'Lleva Biblia', 20), //[cite: 1]
                          _botontPuntos(context, nino['id'], 'Versículo', 30), //[cite: 1]
                          _botontPuntos(context, nino['id'], 'Estaciones', 20), //[cite: 1]
                          _botontPuntos(context, nino['id'], 'Respeto/Obediencia', 20), //[cite: 1]
                          _botontPuntos(context, nino['id'], 'Invitado', 50), //[cite: 1]
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _botontPuntos(BuildContext context, String ninoId, String concepto, int xp) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF334155),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
      onPressed: () => _sumarXP(context, ninoId, concepto, xp),
      child: Text('+$xp XP $concepto', style: const TextStyle(fontSize: 12, color: Colors.white)),
    );
  }
}

// -----------------------------------------------------------------------------
// 3. PANTALLA MODO PROYECTOR / TABLERO DE EQUIPOS (REALTIME)
// -----------------------------------------------------------------------------
/*
class ProyectorScreen extends StatelessWidget {
  const ProyectorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🏆 TABLERO GAME ON - EN VIVO 🏆', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.indigo,
      ),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        // Escucha cambios en la tabla de equipos en tiempo real
        stream: supabase.from('equipos').stream(primaryKey: ['id']).order('xp_totales', ascending: false),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
          final equipos = snapshot.data!;

          return Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                const Text(
                  'COPA GAME-ON', //[cite: 3]
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.amber),
                ),
                const SizedBox(height: 24),
                Expanded(
                  child: ListView.builder(
                    itemCount: equipos.length,
                    itemBuilder: (context, index) {
                      final equipo = equipos[index];
                      final xp = equipo['xp_totales'] ?? 0;

                      return Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1E293B),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.amber.withOpacity(0.5)),
                        ),
                        child: Row(
                          children: [
                            Text(
                              '#${index + 1}',
                              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.amber),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    equipo['nombre'],
                                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 8),
                                  // Barra estilo videojuego
                                  LinearProgressIndicator(
                                    value: (xp / 2000).clamp(0.0, 1.0), // Ajustar escala según XP esperados por equipo
                                    minHeight: 12,
                                    backgroundColor: Colors.black26,
                                    color: Colors.amber,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 16),
                            Text(
                              '$xp XP',
                              style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.greenAccent),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
*/

class DialogoInsignias extends StatefulWidget {
  final String ninoId;
  final String ninoNombre;
  const DialogoInsignias({super.key, required this.ninoId, required this.ninoNombre});

  @override
  State<DialogoInsignias> createState() => _DialogoInsigniasState();
}

class _DialogoInsigniasState extends State<DialogoInsignias> {
  List<Map<String, dynamic>> _insignias = [];
  Set<String> _insigniasObtenidas = {};

  @override
  void initState() {
    super.initState();
    _cargarInsignias();
  }

  Future<void> _cargarInsignias() async {
    final provider = context.read<SupabaseProvider>();
    final catalog = await provider.obtenerCatalogoInsignias();
    final asignadas = await provider.obtenerInsigniasDeNino(widget.ninoId);

    setState(() {
      _insignias = catalog;
      _insigniasObtenidas = asignadas;
    });
  }

  Future<void> _toggleInsignia(String insigniaId, bool otorgar) async {
    final provider = context.read<SupabaseProvider>();
    await provider.toggleInsigniaNino(
      ninoId: widget.ninoId,
      insigniaId: insigniaId,
      otorgar: otorgar,
    );

    setState(() {
      if (otorgar) {
        _insigniasObtenidas.add(insigniaId);
      } else {
        _insigniasObtenidas.remove(insigniaId);
      }
    });
  }

  /*
  Future<void> _toggleInsignia(String insigniaId, bool otorgar) async {
    if (otorgar) {
      await supabase.from('insignias_ninos').insert({
        'nino_id': widget.ninoId,
        'insignia_id': insigniaId,
      });
      _insigniasObtenidas.add(insigniaId);
    } else {
      await supabase.from('insignias_ninos').delete().match({
        'nino_id': widget.ninoId,
        'insignia_id': insigniaId,
      });
      _insigniasObtenidas.remove(insigniaId);
    }
    setState(() {});
  }
  */

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Insignias de ${widget.ninoNombre}'),
      content: SizedBox(
        width: double.maxFinite,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: _insignias.length,
          itemBuilder: (context, index) {
            final ins = _insignias[index];
            final id = ins['id'].toString();
            final otorgada = _insigniasObtenidas.contains(id);

            return CheckboxListTile(
              title: Text(ins['nombre']),
              subtitle: Text(ins['descripcion'] ?? ''),
              value: otorgada,
              onChanged: (bool? val) {
                if (val != null) _toggleInsignia(id, val);
              },
            );
          },
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cerrar')),
      ],
    );
  }
}