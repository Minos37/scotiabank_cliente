import 'package:flutter/material.dart';

class PlinScreen extends StatefulWidget {
  const PlinScreen({super.key});

  @override
  State<PlinScreen> createState() => _PlinScreenState();
}

class _PlinScreenState extends State<PlinScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _simulateScan() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Iniciando lector de QR...')),
    );
  }

  void _showContactPicker() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Enviar a un contacto',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                hintText: 'Nombre o número de celular',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.red[50],
                child: const Icon(Icons.person, color: Color(0xFFEC111A)),
              ),
              title: const Text('Maria Garcia'),
              subtitle: const Text('912 345 678'),
              onTap: () => Navigator.pop(context),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
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
            'Scotiabank.',
            style: TextStyle(
              color: Color(0xFFEC111A),
              fontWeight: FontWeight.bold,
            ),
          ),
          bottom: TabBar(
            controller: _tabController,
            indicatorColor: const Color(0xFFEC111A),
            labelColor: const Color(0xFFEC111A),
            unselectedLabelColor: Colors.grey,
            tabs: const [
              Tab(text: 'Pagar'),
              Tab(text: 'Mi QR'),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            // Pestaña Pagar
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.qr_code_scanner, size: 80, color: Color(0xFF005EB8)),
                const SizedBox(height: 24),
                const Text(
                  'Envía dinero al instante',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Escanéa un QR o elige a un contacto',
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 48),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFEC111A),
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                        onPressed: _simulateScan,
                        child: const Text('Escanear QR', style: TextStyle(color: Colors.white)),
                      ),
                      const SizedBox(height: 16),
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50),
                          side: const BorderSide(color: Color(0xFFEC111A)),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                        onPressed: _showContactPicker,
                        child: const Text('Enviar por contacto', style: TextStyle(color: Color(0xFFEC111A))),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // Pestaña Mi QR
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Tu código QR para cobrar',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 24),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 20,
                        )
                      ],
                    ),
                    child: const Icon(Icons.qr_code_2, size: 200, color: Colors.black87),
                  ),
                  const SizedBox(height: 32),
                  TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.share, color: Color(0xFF005EB8)),
                    label: const Text('Compartir mi QR', style: TextStyle(color: Color(0xFF005EB8))),
                  ),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: 2,
          onTap: (index) {
            if (index == 2) return;
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
      case 1: Navigator.pushReplacementNamed(context, '/mi-lista'); break;
      case 3: Navigator.pushReplacementNamed(context, '/notificaciones'); break;
      case 4: Navigator.pushReplacementNamed(context, '/perfil'); break;
    }
  }
}