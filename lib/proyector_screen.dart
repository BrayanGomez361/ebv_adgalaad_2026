import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/supabase_provider.dart';

class ProyectorScreen extends StatelessWidget {
  const ProyectorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Obtenemos el cliente de Supabase desde el provider
    final supabaseClient = context.read<SupabaseProvider>().client;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '🏆 TABLERO GAME ON - EN VIVO 🏆',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.indigo,
      ),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        // Escucha cambios en la tabla de equipos en tiempo real a través del cliente del provider
        stream: supabaseClient
            .from('equipos')
            .stream(primaryKey: ['id'])
            .order('xp_totales', ascending: false),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error al cargar el tablero: ${snapshot.error}',
                style: const TextStyle(color: Colors.redAccent),
              ),
            );
          }

          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final equipos = snapshot.data!;

          if (equipos.isEmpty) {
            return const Center(
              child: Text(
                'No hay equipos registrados aún.',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                const Text(
                  'COPA GAME-ON',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.amber,
                  ),
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
                          border: Border.all(
                            color: Colors.amber.withOpacity(0.5),
                          ),
                        ),
                        child: Row(
                          children: [
                            Text(
                              '#${index + 1}',
                              style: const TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.amber,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    equipo['nombre'] ?? 'Sin Nombre',
                                    style: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  // Barra estilo videojuego
                                  LinearProgressIndicator(
                                    value: (xp / 2000).clamp(0.0, 1.0), // Ajustar según la meta global de XP
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
                              style: const TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                color: Colors.greenAccent,
                              ),
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