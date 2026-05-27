import 'package:flutter/material.dart';
import 'screen.dart';
import '../ui/screens/splash_screen.dart';
import '../ui/screens/login_screen.dart';
import '../ui/screens/home_screen.dart';
import '../ui/screens/cuenta_screen.dart';
import '../ui/screens/tarjeta_screen.dart';
import '../ui/screens/prestamo_screen.dart';
import '../ui/screens/operaciones_screen.dart';
import '../ui/screens/notificaciones_screen.dart';
import '../ui/screens/contacto_screen.dart';
import '../ui/screens/mi_lista_screen.dart';
import '../ui/screens/plin_screen.dart';
import '../ui/screens/perfil_screen.dart';
import '../ui/screens/datos_personales_screen.dart';

class AppNavigator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/splash':
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case '/login':
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case '/home':
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case '/cuenta':
        return MaterialPageRoute(builder: (_) => const CuentaScreen());
      case '/tarjeta':
        return MaterialPageRoute(builder: (_) => const TarjetaScreen());
      case '/prestamo':
        return MaterialPageRoute(builder: (_) => const PrestamoScreen());
      case '/operaciones':
        return MaterialPageRoute(builder: (_) => const OperacionesScreen());
      case '/mi-lista':
        return MaterialPageRoute(builder: (_) => const MiListaScreen());
      case '/plin':
        return MaterialPageRoute(builder: (_) => const PlinScreen());
      case '/notificaciones':
        return MaterialPageRoute(builder: (_) => const NotificacionesScreen());
      case '/contacto':
        return MaterialPageRoute(builder: (_) => const ContactoScreen());
      case '/perfil':
        return MaterialPageRoute(builder: (_) => const PerfilScreen());
      case '/datos-personales':
        return MaterialPageRoute(builder: (_) => const DatosPersonalesScreen());
      default:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
    }
  }
}
