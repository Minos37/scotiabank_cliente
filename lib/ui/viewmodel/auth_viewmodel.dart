import 'package:flutter/material.dart';
import '../../data/model/auth_models.dart';
import '../../data/local/auth_service.dart';
import '../../data/remote/auth_api.dart';
import 'ui_state.dart';

class AuthViewModel extends ChangeNotifier {
  UiState _state = const UiEmpty();
  String? _userId;
  String? _userEmail;
  final _authApi = AuthApi();

  UiState get state => _state;
  String? get userId => _userId;
  String? get userEmail => _userEmail;
  bool get isLoggedIn => _userId != null;

  Future<void> login(String email, String password) async {
    _state = const UiLoading();
    notifyListeners();

    try {
      await AuthService.signIn(email, password);

      _userId = AuthService.getCurrentUserId();
      _userEmail = AuthService.getCurrentUserEmail();

      final response = AuthResponse(
        id: _userId ?? '',
        usuario: email.split('@')[0],
        token: 'supabase_token',
        email: email,
      );

      _state = UiSuccess(response);
      notifyListeners();
    } catch (e) {
      _state = UiError(e.toString());
      notifyListeners();
    }
  }

  Future<void> signup(String email, String password) async {
    _state = const UiLoading();
    notifyListeners();

    try {
      await AuthService.signUp(email, password);

      _userId = AuthService.getCurrentUserId();
      _userEmail = AuthService.getCurrentUserEmail();

      final response = AuthResponse(
        id: _userId ?? '',
        usuario: email.split('@')[0],
        token: 'supabase_token',
        email: email,
      );

      _state = UiSuccess(response);
      notifyListeners();
    } catch (e) {
      _state = UiError(e.toString());
      notifyListeners();
    }
  }

  Future<void> logout() async {
    try {
      await AuthService.signOut();
      _userId = null;
      _userEmail = null;
      _state = const UiEmpty();
      notifyListeners();
    } catch (e) {
      _state = UiError(e.toString());
      notifyListeners();
    }
  }

  Future<bool> updateProfile(Map<String, dynamic> data) async {
    if (_userId == null) return false;
    
    try {
      final success = await _authApi.updateProfile(_userId!, data);
      if (success) {
        if (data.containsKey('correo') || data.containsKey('email')) {
          _userEmail = data['correo'] ?? data['email'];

          // Sincronizar el objeto AuthResponse dentro del estado UiSuccess
          if (_state is UiSuccess) {
            final currentResponse = (_state as UiSuccess).data as AuthResponse;
            _state = UiSuccess(AuthResponse(
              id: currentResponse.id,
              usuario: _userEmail?.split('@')[0] ?? currentResponse.usuario,
              token: currentResponse.token,
              email: _userEmail ?? currentResponse.email,
            ));
          }
        }
        notifyListeners();
      }
      return success;
    } catch (e) {
      return false;
    }
  }

  void checkAuthStatus() {
    if (AuthService.isLoggedIn()) {
      _userId = AuthService.getCurrentUserId();
      _userEmail = AuthService.getCurrentUserEmail();
      _state = UiSuccess(AuthResponse(
        id: _userId ?? '',
        usuario: _userEmail?.split('@')[0] ?? '',
        token: 'supabase_token',
        email: _userEmail ?? '',
      ));
    } else {
      _state = const UiEmpty();
    }
    notifyListeners();
  }

  void clearState() {
    _state = const UiEmpty();
    notifyListeners();
  }
}
