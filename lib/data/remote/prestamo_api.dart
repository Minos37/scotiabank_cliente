import '../model/prestamo_models.dart';

class PrestamoApi {
  Future<List<Prestamo>> getPrestamos() async {
    try {
      await Future.delayed(const Duration(seconds: 1));

      return [
        Prestamo(
          id: '1',
          montoTotal: 50000.00,
          montoPagado: 15000.00,
          montoPendiente: 35000.00,
          moneda: 'PEN',
          tasaInteres: 8.5,
          plazoMeses: 60,
          mesesPagados: 12,
          estado: 'Activo',
          fechaDesembolso: DateTime(2023, 6, 15),
          fechaProximaCuota: DateTime.now().add(const Duration(days: 15)),
        ),
        Prestamo(
          id: '2',
          montoTotal: 25000.00,
          montoPagado: 10000.00,
          montoPendiente: 15000.00,
          moneda: 'USD',
          tasaInteres: 7.2,
          plazoMeses: 36,
          mesesPagados: 8,
          estado: 'Activo',
          fechaDesembolso: DateTime(2023, 10, 20),
          fechaProximaCuota: DateTime.now().add(const Duration(days: 10)),
        ),
      ];
    } catch (e) {
      throw Exception('Error obteniendo préstamos: $e');
    }
  }
}
