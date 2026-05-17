import '../model/tarjeta_models.dart';
import '../remote/tarjeta_api.dart';

class TarjetaRepository {
  final TarjetaApi _tarjetaApi = TarjetaApi();

  Future<List<Tarjeta>> getTarjetas() async {
    return await _tarjetaApi.getTarjetas();
  }
}
