import '../model/cuenta_models.dart';
import '../remote/cuenta_api.dart';

class CuentaRepository {
  final CuentaApi _cuentaApi = CuentaApi();

  Future<List<Cuenta>> getCuentas() async {
    return await _cuentaApi.getCuentas();
  }

  Future<List<Movimiento>> getMovimientos(String cuentaId) async {
    return await _cuentaApi.getMovimientos(cuentaId);
  }
}
