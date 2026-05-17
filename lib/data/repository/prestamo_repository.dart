import '../model/prestamo_models.dart';
import '../remote/prestamo_api.dart';

class PrestamoRepository {
  final PrestamoApi _prestamoApi = PrestamoApi();

  Future<List<Prestamo>> getPrestamos() async {
    return await _prestamoApi.getPrestamos();
  }
}
