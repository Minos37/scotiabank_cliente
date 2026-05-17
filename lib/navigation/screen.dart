enum AppScreen {
  splash,
  login,
  home,
  cuenta,
  tarjeta,
  prestamo,
  operaciones,
  notificaciones,
  contacto,
  perfil,
}

extension AppScreenExtension on AppScreen {
  String get routeName {
    switch (this) {
      case AppScreen.splash:
        return '/splash';
      case AppScreen.login:
        return '/login';
      case AppScreen.home:
        return '/home';
      case AppScreen.cuenta:
        return '/cuenta';
      case AppScreen.tarjeta:
        return '/tarjeta';
      case AppScreen.prestamo:
        return '/prestamo';
      case AppScreen.operaciones:
        return '/operaciones';
      case AppScreen.notificaciones:
        return '/notificaciones';
      case AppScreen.contacto:
        return '/contacto';
      case AppScreen.perfil:
        return '/perfil';
    }
  }

  String get screenName {
    switch (this) {
      case AppScreen.splash:
        return 'SplashScreen';
      case AppScreen.login:
        return 'LoginScreen';
      case AppScreen.home:
        return 'HomeScreen';
      case AppScreen.cuenta:
        return 'CuentaScreen';
      case AppScreen.tarjeta:
        return 'TarjetaScreen';
      case AppScreen.prestamo:
        return 'PrestamoScreen';
      case AppScreen.operaciones:
        return 'OperacionesScreen';
      case AppScreen.notificaciones:
        return 'NotificacionesScreen';
      case AppScreen.contacto:
        return 'ContactoScreen';
      case AppScreen.perfil:
        return 'PerfilScreen';
    }
  }
}
