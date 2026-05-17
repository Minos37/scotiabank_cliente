import '../model/auth_models.dart';

class AuthApi {
  // Simulación de API call
  Future<AuthResponse> login(AuthRequest request) async {
    try {
      await Future.delayed(const Duration(seconds: 2));

      return AuthResponse(
        id: '1',
        usuario: request.usuario,
        token: 'token_example_${DateTime.now().millisecondsSinceEpoch}',
        email: '${request.usuario}@scotiabank.com',
      );
    } catch (e) {
      throw Exception('Error en login: $e');
    }
  }

  Future<bool> logout() async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      return true;
    } catch (e) {
      throw Exception('Error en logout: $e');
    }
  }

  Future<AuthResponse> refreshToken(String token) async {
    try {
      await Future.delayed(const Duration(seconds: 1));

      return AuthResponse(
        id: '1',
        usuario: 'usuario',
        token: 'token_example_${DateTime.now().millisecondsSinceEpoch}',
        email: 'usuario@scotiabank.com',
      );
    } catch (e) {
      throw Exception('Error refreshing token: $e');
    }
  }
}
