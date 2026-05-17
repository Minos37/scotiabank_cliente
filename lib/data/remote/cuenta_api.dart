import '../model/cuenta_models.dart';

class CuentaApi {
  Future<List<Cuenta>> getCuentas() async {
    try {
      await Future.delayed(const Duration(seconds: 1));

      return [
        Cuenta(
          id: '1',
          numero: '1234567890',
          tipo: 'Ahorros',
          moneda: 'PEN',
          saldo: 5000.00,
          estado: 'Activa',
          fechaApertura: DateTime(2020, 1, 15),
        ),
        Cuenta(
          id: '2',
          numero: '0987654321',
          tipo: 'Corriente',
          moneda: 'USD',
          saldo: 2500.00,
          estado: 'Activa',
          fechaApertura: DateTime(2021, 6, 20),
        ),
      ];
    } catch (e) {
      throw Exception('Error obteniendo cuentas: $e');
    }
  }

  Future<List<Movimiento>> getMovimientos(String cuentaId) async {
    try {
      await Future.delayed(const Duration(seconds: 1));

      return [
        Movimiento(
          id: '1',
          tipo: 'Transferencia',
          monto: 500.00,
          concepto: 'Pago de servicios',
          fecha: DateTime.now().subtract(const Duration(days: 1)),
          estado: 'Completado',
          referencia: 'REF001',
        ),
        Movimiento(
          id: '2',
          tipo: 'Depósito',
          monto: 1000.00,
          concepto: 'Nómina',
          fecha: DateTime.now().subtract(const Duration(days: 5)),
          estado: 'Completado',
          referencia: 'REF002',
        ),
      ];
    } catch (e) {
      throw Exception('Error obteniendo movimientos: $e');
    }
  }
}
