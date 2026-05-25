import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../viewmodel/auth_viewmodel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Mantenemos la lógica de logout existente
  void _handleLogout(BuildContext context) async {
    final authViewModel = Provider.of<AuthViewModel>(context, listen: false);
    final navigator = Navigator.of(context);
    await authViewModel.logout();

    if (mounted) {
      navigator.pushNamedAndRemoveUntil(
        '/login',
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark, // Iconos de estado oscuros para fondo blanco
      child: Scaffold(
        backgroundColor: const Color(0xFFF7F8FA),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTopBar(),
                _buildTabs(),
                _buildProductList(),
                _buildQuickActions(),
                _buildPromoBanner(),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
        bottomNavigationBar: _buildBottomNavBar(),
      ),
    );
  }

  Widget _buildTopBar() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Scotiabank',
            style: TextStyle(
              color: Color(0xFFEC111A),
              fontSize: 22,
              fontWeight: FontWeight.w900,
              letterSpacing: -1.2,
            ),
          ),
          // Tarjeta de puntos
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFF4F4F4),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                const Text(
                  '34,228 pts',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black87),
                ),
                const SizedBox(width: 6),
                _buildColorDots(),
              ],
            ),
          ),
          // Botón QR
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: const Icon(Icons.qr_code_scanner, size: 20, color: Colors.black87),
          ),
        ],
      ),
    );
  }

  Widget _buildColorDots() {
    return Row(
      children: [
        _dot(Colors.red),
        _dot(Colors.orange),
        _dot(Colors.purple),
      ],
    );
  }

  Widget _dot(Color color) => Container(
        margin: const EdgeInsets.only(left: 2),
        width: 6,
        height: 6,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      );

  Widget _buildTabs() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(top: 8),
      child: Row(
        children: [
          _tabItem("Mis productos", active: true),
          _tabItem("Quiero", active: false),
        ],
      ),
    );
  }

  Widget _tabItem(String text, {required bool active}) {
    return Expanded(
      child: Column(
        children: [
          Text(
            text,
            style: TextStyle(
              color: active ? Colors.black87 : Colors.grey,
              fontWeight: active ? FontWeight.bold : FontWeight.normal,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            height: 3,
            width: double.infinity,
            color: active ? const Color(0xFFEC111A) : Colors.transparent,
          )
        ],
      ),
    );
  }

  Widget _buildProductList() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          _buildProductCard("Cuenta Sueldo", subtitle: "S/ 2,450.00"),
          _buildProductCard("Cuenta Digital", subtitle: "S/ 820.50"),
          _buildProductCard("Mis tarjetas", icon: Icons.credit_card, iconColor: Colors.red),
          _buildProductCard("Adquirir productos", icon: Icons.storefront, iconColor: Colors.purple),
        ],
      ),
    );
  }

  Widget _buildProductCard(String title, {String? subtitle, IconData? icon, Color? iconColor}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: Row(
        children: [
          if (icon != null) ...[
            Icon(icon, color: iconColor, size: 24),
            const SizedBox(width: 16),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
                if (subtitle != null) ...[
                  const SizedBox(height: 4),
                  Text(subtitle, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                ],
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: Colors.blue, size: 20),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _actionText("Ocultar"),
          _divider(),
          _actionText("Editar"),
          _divider(),
          _actionText("Ver productos"),
        ],
      ),
    );
  }

  Widget _actionText(String text) => Text(
        text,
        style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.w600, fontSize: 14),
      );

  Widget _divider() => Container(
        margin: const EdgeInsets.symmetric(horizontal: 12),
        height: 14,
        width: 1,
        color: Colors.grey.shade300,
      );

  Widget _buildPromoBanner() {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF6A1B9A), Color(0xFF8E24AA)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Visa Signature",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Lleva tu experiencia al siguiente nivel.",
                  style: TextStyle(color: Colors.white70, fontSize: 13),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.purple,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    elevation: 0,
                  ),
                  child: const Text("Me interesa", style: TextStyle(fontWeight: FontWeight.bold)),
                )
              ],
            ),
          ),
          Container(
            height: 80,
            width: 100,
            decoration: BoxDecoration(
              color: Colors.black26,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.credit_card, color: Colors.black54, size: 50),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavBar() {
    return BottomNavigationBar(
      currentIndex: 0,
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      selectedItemColor: const Color(0xFFEC111A),
      unselectedItemColor: Colors.grey,
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_outlined), activeIcon: Icon(Icons.home), label: 'Inicio'),
        BottomNavigationBarItem(icon: Icon(Icons.list_alt), label: 'Mi Lista'),
        BottomNavigationBarItem(icon: Icon(Icons.monetization_on_outlined), label: 'Plin'),
        BottomNavigationBarItem(icon: Icon(Icons.notifications_none), label: 'Avisos'),
        BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Mi Cuenta'),
      ],
    );
  }
}
