import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodel/auth_viewmodel.dart';

class PerfilScreen extends StatelessWidget {
  const PerfilScreen({super.key});

  void _handleLogout(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context, listen: false);
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cerrar sesión'),
        content: const Text('¿Estás seguro de que deseas salir de tu cuenta?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar', style: TextStyle(color: Colors.grey)),
          ),
          TextButton(
            onPressed: () async {
              await authViewModel.logout();
              if (context.mounted) {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  '/login',
                  (route) => false,
                );
              }
            },
            child: const Text('Cerrar sesión', style: TextStyle(color: Color(0xFFEC111A))),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    // Extraemos el nombre del email si no hay nombre completo disponible
    final displayName = authViewModel.isLoggedIn 
        ? (authViewModel.userEmail?.split('@')[0] ?? 'Usuario')
        : 'Usuario';

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        // En lugar de volver al Splash, redirigimos a la pantalla de Inicio
        Navigator.pushReplacementNamed(context, '/home');
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F5F5),
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            children: [
              const SizedBox(height: 16),
              
              // Logo Scotiabank en la esquina superior izquierda
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Scotiabank.',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: const Color(0xFFEC111A),
                        fontWeight: FontWeight.bold,
                        letterSpacing: -0.5,
                      ),
                ),
              ),
              
              const SizedBox(height: 24),

              // Fila de usuario: Avatar y Nombre
              Row(
                children: [
                  // Avatar circular con representación de "camiseta roja"
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: const Color(0xFFEC111A),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.person_outline,
                      color: Colors.white,
                      size: 35,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        displayName,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      GestureDetector(
                        onTap: () => Navigator.pushNamed(context, '/datos-personales'),
                        child: const Text(
                          'Ver perfil y datos',
                          style: TextStyle(
                            color: const Color(0xFF005EB8), // Azul bancario
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 32),

              // Menú principal: Tarjetas de opciones
              _buildMenuCard(
                icon: Icons.stars_rounded,
                title: 'Scotia Puntos',
                trailing: const Text(
                  '31,999',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.black87,
                  ),
                ),
              ),
              _buildMenuCard(
                icon: Icons.person_pin_outlined, 
                title: 'Mi Funcionario',
                onTap: () => Navigator.pushNamed(context, '/contacto'),
              ),
              _buildMenuCard(
                icon: Icons.assignment_ind_outlined,
                title: 'Datos personales',
                onTap: () => Navigator.pushNamed(context, '/datos-personales'),
              ),
              _buildMenuCard(icon: Icons.settings_outlined, title: 'Configuración'),
              _buildMenuCard(icon: Icons.security_outlined, title: 'Seguridad'),
              _buildMenuCard(icon: Icons.description_outlined, title: 'Documentos'),
              _buildMenuCard(
                icon: Icons.help_outline, 
                title: 'Centro de ayuda',
                onTap: () => Navigator.pushNamed(context, '/contacto'),
              ),
              _buildMenuCard(icon: Icons.shield_outlined, title: 'Seguros'),
              _buildMenuCard(
                icon: Icons.logout, 
                title: 'Cerrar sesión',
                onTap: () => _handleLogout(context),
              ),
              
              const SizedBox(height: 20),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: 4, // "Mi Cuenta" activo
          onTap: (index) {
            if (index == 4) return; // Ya estamos en esta pantalla
            
            switch (index) {
              case 0:
                Navigator.pushReplacementNamed(context, '/home');
                break;
              case 1:
                Navigator.pushReplacementNamed(context, '/mi-lista');
                break;
              case 2:
                Navigator.pushReplacementNamed(context, '/plin');
                break;
              case 3:
                Navigator.pushReplacementNamed(context, '/notificaciones');
                break;
            }
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: const Color(0xFFEC111A),
          unselectedItemColor: Colors.grey[600],
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
          unselectedLabelStyle: const TextStyle(fontSize: 11),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home_outlined), activeIcon: Icon(Icons.home), label: 'Inicio'),
            BottomNavigationBarItem(icon: Icon(Icons.list_alt_outlined), label: 'Mi Lista'),
            BottomNavigationBarItem(icon: Icon(Icons.qr_code_scanner), label: 'Plin'),
            BottomNavigationBarItem(icon: Icon(Icons.notifications_none_outlined), label: 'Notificaciones'),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person),
              label: 'Mi Cuenta',
            ),
          ],
        ),
      ),
    );
  }

  // Widget reutilizable para las tarjetas del menú
  Widget _buildMenuCard({
    required IconData icon,
    required String title,
    VoidCallback? onTap,
    Widget? trailing,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
        leading: Icon(icon, color: Colors.grey[800], size: 24),
        title: Text(
          title,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.black87),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (trailing != null) ...[trailing, const SizedBox(width: 8)],
            const Icon(Icons.chevron_right, color: Color(0xFF005EB8), size: 22),
          ],
        ),
        onTap: onTap ?? () => debugPrint('Navegando a: $title'),
      ),
    );
  }
}