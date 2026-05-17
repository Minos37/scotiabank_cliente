import '../model/tarjeta_models.dart';

class TarjetaApi {
  Future<List<Tarjeta>> getTarjetas() async {
    try {
      await Future.delayed(const Duration(seconds: 1));

      return [
        Tarjeta(
          id: '1',
          numero: '4532123456789010',
          tipo: 'Visa',
          titular: 'Juan Pérez',
          fechaVencimiento: DateTime(2026, 12, 31),
          estado: 'Activa',
          limiteDisponible: 5000.00,
          limiteTotal: 10000.00,
        ),
        Tarjeta(
          id: '2',
          numero: '5425433123456789',
          tipo: 'Mastercard',
          titular: 'Juan Pérez',
          fechaVencimiento: DateTime(2025, 8, 31),
          estado: 'Activa',
          limiteDisponible: 3000.00,
          limiteTotal: 8000.00,
        ),
      ];
    } catch (e) {
      throw Exception('Error obteniendo tarjetas: $e');
    }
  }
}
