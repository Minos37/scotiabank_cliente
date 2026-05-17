import '../model/prestamo_models.dart';
import '../supabase_service.dart';

class PrestamoService {
  static const String _table = 'prestamos';

  static Future<List<Prestamo>> obtenerPrestamos() async {
    try {
      final response = await SupabaseService.read(_table);
      return response.map((json) => Prestamo.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Error al obtener préstamos: $e');
    }
  }

  static Future<Prestamo> obtenerPrestamoPorId(String id) async {
    try {
      final response = await SupabaseService.client
          .from(_table)
          .select()
          .eq('id', id)
          .single();
      return Prestamo.fromJson(response);
    } catch (e) {
      throw Exception('Error al obtener préstamo: $e');
    }
  }

  static Future<void> crearPrestamo(Prestamo prestamo) async {
    try {
      await SupabaseService.insert(_table, prestamo.toJson());
    } catch (e) {
      throw Exception('Error al crear préstamo: $e');
    }
  }

  static Future<void> actualizarPrestamo(String id, Prestamo prestamo) async {
    try {
      await SupabaseService.update(_table, prestamo.toJson(), id);
    } catch (e) {
      throw Exception('Error al actualizar préstamo: $e');
    }
  }

  static Future<void> eliminarPrestamo(String id) async {
    try {
      await SupabaseService.delete(_table, id);
    } catch (e) {
      throw Exception('Error al eliminar préstamo: $e');
    }
  }
}
