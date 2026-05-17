import 'package:flutter/material.dart';
import 'ui_state.dart';

class TarjetaViewModel extends ChangeNotifier {
  UiState _state = const UiEmpty();

  UiState get state => _state;

  Future<void> loadTarjetas() async {
    _state = const UiLoading();
    notifyListeners();

    try {
      await Future.delayed(const Duration(seconds: 1));
      _state = const UiSuccess(null);
      notifyListeners();
    } catch (e) {
      _state = UiError(e.toString());
      notifyListeners();
    }
  }

  void clearState() {
    _state = const UiEmpty();
    notifyListeners();
  }
}
