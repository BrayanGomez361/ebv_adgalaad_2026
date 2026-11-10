import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

double fontSizeLarge = 24.0;
  double fontSize = 14.0;
  double fontSmall = 12.0;

class ProgramViewScreen extends StatelessWidget {
  const ProgramViewScreen({super.key});

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CupertinoColors.black,
      body: CustomScrollView(
        slivers: [
          // 1. Barra superior nativa Cupertino
          const CupertinoSliverNavigationBar(
            largeTitle: Text(
              'Programa Diario',
              style: TextStyle(color: Colors.white),
            ),
            
            backgroundColor: CupertinoColors.black,
            border: null,
          ),

          // 2. Subtítulo / Nota explicativa
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 4.0, 16.0, 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(
                    'Horario y cronograma de actividades de la EBV',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.6),
                      fontSize: fontSize,
                    ),
                  ),







                ],
              ),
            ),
          ),

          // 3. Lista dinámicamente construida en el Sliver
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final item = programaEBV[index];
                  return _ItemProgramaWidget(actividad: item);
                },
                childCount: programaEBV.length,
              ),
            ),
          ),
          
          const SliverToBoxAdapter(child: SizedBox(height: 150)),
        ],
      ),
    );
  }
}

// Componente para cada bloque del programa estilo Timeline Cupertino
class _ItemProgramaWidget extends StatelessWidget {
  final ActividadPrograma actividad;

  const _ItemProgramaWidget({required this.actividad});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12.0),
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: CupertinoColors.secondarySystemFill,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Bloque de tiempo (Izquierda)
          SizedBox(
            width: 85,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  actividad.hora,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 109, 167, 220),
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '(${actividad.duracion})',
                  style: const TextStyle(
                    color: Colors.white54,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),

          // Línea divisora sutil
          Container(
            height: 45,
            width: 1,
            color: Colors.white12,
            margin: const EdgeInsets.symmetric(horizontal: 8),
          ),

          // Bloque de contenido principal (Derecha)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  actividad.titulo,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),

                // Lista de viñetas/detalles
                ...actividad.detalles.map(
                  (detalle) => Padding(
                    padding: const EdgeInsets.only(bottom: 2.0),
                    child: Text(
                      '• $detalle',
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                // Footer con encargado e indicaciones
                Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  children: [
                    _BadgeInfo(
                      icon: CupertinoIcons.person_fill,
                      label: actividad.encargado,
                      color: Colors.white38,
                    ),
                    if (actividad.indicaciones != null)
                      _BadgeInfo(
                        icon: CupertinoIcons.exclamationmark_triangle_fill,
                        label: actividad.indicaciones!,
                        color: Colors.amber.shade300,
                      ),
                  ],
                ),

                
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Helper badge pequeño para Encargado e Indicaciones
class _BadgeInfo extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _BadgeInfo({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 12, color: color),
        const SizedBox(width: 4),
        Flexible(
          child: Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}



class ActividadPrograma {
  final String hora;
  final String duracion;
  final String titulo;
  final List<String> detalles;
  final String encargado;
  final String? indicaciones;

  const ActividadPrograma({
    required this.hora,
    required this.duracion,
    required this.titulo,
    required this.detalles,
    required this.encargado,
    this.indicaciones,
  });
}

// Lista basada en tu imagen
final List<ActividadPrograma> programaEBV = const [
  ActividadPrograma(
    hora: 'Previo a comenzar',
    duracion: '-',
    titulo: 'Preparativos',
    detalles: ['Oración grupal', 'Preparar templo y salones','Recibir a niños y padres'],
    encargado: 'Todo el equipo',
    //indicaciones: 'Estar puntual',
  ),
  ActividadPrograma(
    hora: '3:00 - 3:05',
    duracion: '5 min',
    titulo: 'Apertura',
    detalles: ['Bienvenida', 'Lectura, Oración'],
    encargado: '1er día Pastor / 2do día Alfredo / 3er día Mayra',
    indicaciones: 'Estar puntual',
  ),
  ActividadPrograma(
    hora: '3:05 - 3:20',
    duracion: '15 min',
    titulo: 'Alabanza',
    detalles: ['Coreografía lema', 'Coreografía del día'],
    encargado: 'Todo el equipo',
  ),
  ActividadPrograma(
    hora: '3:20 - 3:25',
    duracion: '5 min',
    titulo: 'Traslado a cada clase',
    detalles: ['Por edades, en orden, un grupo a la vez'],
    encargado: 'Maestros de grupo',
  ),
  ActividadPrograma(
    hora: '3:25 - 4:45',
    duracion: '1h 20 min',
    titulo: 'Clase',
    detalles: ['Nivel de Sabiduría, HT', 'Manualidad, Historia Misionera'],
    encargado: 'Maestros',
  ),
  ActividadPrograma(
    hora: '4:45 - 5:00',
    duracion: '15 min',
    titulo: 'Clausura',
    detalles: ['Coreografía lema', 'Ofrenda general', 'Oración final'],
    encargado: 'Quien dirige',
  ),
  ActividadPrograma(
    hora: '5:00 pm',
    duracion: 'Salida',
    titulo: 'Refacción',
    detalles: ['Los niños salen para su casa con la refacción'],
    encargado: 'Equipo de refacción',
  ),
  ActividadPrograma(
    hora: 'Final',
    duracion: '-',
    titulo: 'Limpieza',
    detalles: ['Templo y salones'],
    encargado: 'Cada grupo de maestros',
  ),
];