import '../model/tarjeta_models.dart';
import '../supabase_service.dart';

class TarjetaService {
  static const String _table = 'tarjetas';

  static Future<List<Tarjeta>> obtenerTarjetas() async {
    try {
      final response = await SupabaseService.read(_table);
      return response.map((json) => Tarjeta.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Error al obtener tarjetas: $e');
    }
  }

  static Future<Tarjeta> obtenerTarjetaPorId(String id) async {
    try {
      final response = await SupabaseService.client
          .from(_table)
          .select()
          .eq('id', id)
          .single();
      return Tarjeta.fromJson(response);
    } catch (e) {
      throw Exception('Error al obtener tarjeta: $e');
    }
  }

  static Future<void> crearTarjeta(Tarjeta tarjeta) async {
    try {
      await SupabaseService.insert(_table, tarjeta.toJson());
    } catch (e) {
      throw Exception('Error al crear tarjeta: $e');
    }
  }

  static Future<void> actualizarTarjeta(String id, Tarjeta tarjeta) async {
    try {
      await SupabaseService.update(_table, tarjeta.toJson(), id);
    } catch (e) {
      throw Exception('Error al actualizar tarjeta: $e');
    }
  }

  static Future<void> eliminarTarjeta(String id) async {
    try {
      await SupabaseService.delete(_table, id);
    } catch (e) {
      throw Exception('Error al eliminar tarjeta: $e');
    }
  }
}
