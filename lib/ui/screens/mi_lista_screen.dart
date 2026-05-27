import 'package:flutter/material.dart';

class MiListaScreen extends StatelessWidget {
  const MiListaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        Navigator.pushReplacementNamed(context, '/home');
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F5F5),
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            children: [
              const SizedBox(height: 16),
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
              const Text(
                'Mi Lista',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 100),
              const Center(
                child: Column(
                  children: [
                    Icon(Icons.list_alt_outlined, size: 80, color: Colors.grey),
                    SizedBox(height: 16),
                    Text('Aún no tienes elementos en tu lista', 
                      style: TextStyle(color: Colors.grey, fontSize: 16)),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: 1,
          onTap: (index) {
            if (index == 1) return;
            _handleNavigation(context, index);
          },
          type: BottomNavigationBarType.fixed,
          selectedItemColor: const Color(0xFFEC111A),
          unselectedItemColor: Colors.grey[600],
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Inicio'),
            BottomNavigationBarItem(icon: Icon(Icons.list_alt_outlined), label: 'Mi Lista'),
            BottomNavigationBarItem(icon: Icon(Icons.qr_code_scanner), label: 'Plin'),
            BottomNavigationBarItem(icon: Icon(Icons.notifications_none_outlined), label: 'Notificaciones'),
            BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Mi Cuenta'),
          ],
        ),
      ),
    );
  }

  void _handleNavigation(BuildContext context, int index) {
    switch (index) {
      case 0: Navigator.pushReplacementNamed(context, '/home'); break;
      case 2: Navigator.pushReplacementNamed(context, '/plin'); break;
      case 3: Navigator.pushReplacementNamed(context, '/notificaciones'); break;
      case 4: Navigator.pushReplacementNamed(context, '/perfil'); break;
    }
  }
}