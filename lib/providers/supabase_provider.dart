

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseProvider extends ChangeNotifier {
  final SupabaseClient client = Supabase.instance.client;

  Map<String, dynamic>? _profesorActual;
  bool _isLoading = false;

  Map<String, dynamic>? get profesorActual => _profesorActual;
  bool get isLoading => _isLoading;

  // Login por PIN
  Future<bool> loginConPin(String pin) async {
    _setLoading(true);
    try {
      final response = await client
          .from('profesores')
          .select()
          .eq('pin', pin)
          .maybeSingle();

      if (response != null) {
        _profesorActual = response;
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      rethrow;
    } finally {
      _setLoading(false);
    }
  }

  // Cerrar Sesión
  void logout() {
    _profesorActual = null;
    notifyListeners();
  }

  // Otorgar XP a un niño
  Future<void> sumarXP({
    required String ninoId,
    required String concepto,
    required int xp,
    DateTime? fecha,
  }) async {
    if (_profesorActual == null) return;

    await client.from('registro_puntos').insert({
      'nino_id': ninoId,
      'profesor_id': _profesorActual!['id'],
      'concepto': concepto,
      'xp_otorgados': xp,
      if (fecha != null) 'created_at': fecha.toIso8601String(),
    });
  }

  // Cargar catálogo de insignias
  Future<List<Map<String, dynamic>>> obtenerCatalogoInsignias() async {
    final response = await client.from('insignias').select();
    return List<Map<String, dynamic>>.from(response);
  }

  // Obtener IDs de insignias asignadas a un niño
  Future<Set<String>> obtenerInsigniasDeNino(String ninoId) async {
    final response = await client
        .from('insignias_ninos')
        .select('insignia_id')
        .eq('nino_id', ninoId);

    return (response as List)
        .map((item) => item['insignia_id'].toString())
        .toSet();
  }

  // Alternar (asignar/quitar) insignia especial
  Future<void> toggleInsigniaNino({
    required String ninoId,
    required String insigniaId,
    required bool otorgar,
  }) async {
    if (otorgar) {
      await client.from('insignias_ninos').insert({
        'nino_id': ninoId,
        'insignia_id': insigniaId,
        'otorgado_por': _profesorActual?['id'],
      });
    } else {
      await client.from('insignias_ninos').delete().match({
        'nino_id': ninoId,
        'insignia_id': insigniaId,
      });
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}