import 'package:flutter/material.dart';

class MiListaScreen extends StatefulWidget {
  const MiListaScreen({super.key});

  @override
  State<MiListaScreen> createState() => _MiListaScreenState();
}

class _MiListaScreenState extends State<MiListaScreen> {
  void _handleNavigation(BuildContext context, int index) {
    switch (index) {
      case 0: Navigator.pushReplacementNamed(context, '/home'); break;
      case 2: Navigator.pushReplacementNamed(context, '/plin'); break;
      case 3: Navigator.pushReplacementNamed(context, '/notificaciones'); break;
      case 4: Navigator.pushReplacementNamed(context, '/perfil'); break;
    }
  }

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
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          automaticallyImplyLeading: false,
          title: const Text(
            'Mi Lista',
            style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.add_circle_outline, color: Color(0xFFEC111A)),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Funcionalidad para agregar contacto en desarrollo')),
                );
              },
            ),
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Buscar contacto o servicio',
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(vertical: 0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  _buildSectionTitle('Contactos frecuentes'),
                  _buildListItem('Maria Garcia', '912 345 678', 'Plin'),
                  _buildListItem('Juan Perez', '191-3456789-0-12', 'Transferencia'),
                  const SizedBox(height: 16),
                  _buildSectionTitle('Servicios guardados'),
                  _buildListItem('Luz del Sur', 'Suministro: 123456', 'Luz'),
                  _buildListItem('Sedapal', 'NIS: 987654', 'Agua'),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: 1, // "Mi Lista" activo
          onTap: (index) {
            if (index == 1) return;
            _handleNavigation(context, index);
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: const Color(0xFFEC111A),
          unselectedItemColor: Colors.grey[600],
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
          unselectedLabelStyle: const TextStyle(fontSize: 11),
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

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Text(
        title,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey),
      ),
    );
  }

  Widget _buildListItem(String title, String subtitle, String tag) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: const Color(0xFFEC111A).withOpacity(0.1),
          child: Text(title[0], style: const TextStyle(color: Color(0xFFEC111A), fontWeight: FontWeight.bold)),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
        subtitle: Text(subtitle, style: TextStyle(color: Colors.grey[600], fontSize: 13)),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(8)),
          child: Text(tag, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.black54)),
        ),
      ),
    );
  }
}