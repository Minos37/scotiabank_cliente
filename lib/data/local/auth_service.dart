import '../supabase_service.dart';

class AuthService {
  static Future<void> signUp(String email, String password) async {
    try {
      await SupabaseService.signUp(email, password);
    } catch (e) {
      throw Exception('Error al registrarse: $e');
    }
  }

  static Future<void> signIn(String email, String password) async {
    try {
      await SupabaseService.signIn(email, password);
    } catch (e) {
      throw Exception('Error al iniciar sesión: $e');
    }
  }

  static Future<void> signOut() async {
    try {
      await SupabaseService.signOut();
    } catch (e) {
      throw Exception('Error al cerrar sesión: $e');
    }
  }

  static String? getCurrentUserId() {
    return SupabaseService.getCurrentUser()?.id;
  }

  static String? getCurrentUserEmail() {
    return SupabaseService.getCurrentUser()?.email;
  }

  static bool isLoggedIn() {
    return SupabaseService.getCurrentUser() != null;
  }
}
