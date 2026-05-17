import '../model/auth_models.dart';
import '../remote/auth_api.dart';

class AuthRepository {
  final AuthApi _authApi = AuthApi();

  Future<AuthResponse> login(String usuario, String contrasena) async {
    final request = AuthRequest(
      usuario: usuario,
      contrasena: contrasena,
    );
    return await _authApi.login(request);
  }

  Future<bool> logout() async {
    return await _authApi.logout();
  }

  Future<AuthResponse> refreshToken(String token) async {
    return await _authApi.refreshToken(token);
  }
}
