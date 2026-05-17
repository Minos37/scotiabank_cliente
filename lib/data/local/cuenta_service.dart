import '../model/cuenta_models.dart';
import '../supabase_service.dart';

class CuentaService {
  static const String _table = 'cuentas';

  static Future<List<Cuenta>> obtenerCuentas() async {
    try {
      final response = await SupabaseService.read(_table);
      return response.map((json) => Cuenta.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Error al obtener cuentas: $e');
    }
  }

  static Future<Cuenta> obtenerCuentaPorId(String id) async {
    try {
      final response = await SupabaseService.client
          .from(_table)
          .select()
          .eq('id', id)
          .single();
      return Cuenta.fromJson(response);
    } catch (e) {
      throw Exception('Error al obtener cuenta: $e');
    }
  }

  static Future<void> crearCuenta(Cuenta cuenta) async {
    try {
      await SupabaseService.insert(_table, cuenta.toJson());
    } catch (e) {
      throw Exception('Error al crear cuenta: $e');
    }
  }

  static Future<void> actualizarCuenta(String id, Cuenta cuenta) async {
    try {
      await SupabaseService.update(_table, cuenta.toJson(), id);
    } catch (e) {
      throw Exception('Error al actualizar cuenta: $e');
    }
  }

  static Future<void> eliminarCuenta(String id) async {
    try {
      await SupabaseService.delete(_table, id);
    } catch (e) {
      throw Exception('Error al eliminar cuenta: $e');
    }
  }
}
