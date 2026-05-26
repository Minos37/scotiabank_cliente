import 'package:flutter/material.dart';
import '../../data/model/tarjeta_models.dart';

class TarjetaScreen extends StatelessWidget {
  const TarjetaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Simulamos una tarjeta basada en tu modelo de datos
    final tarjetaMock = Tarjeta(
      id: '1',
      numero: '4557880012345678',
      tipo: 'Visa Signature',
      titular: 'CESAR AUGUSTO',
      fechaVencimiento: DateTime(2028, 12),
      estado: 'Activa',
      limiteDisponible: 12450.00,
      limiteTotal: 25000.00,
    );

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Detalle de tarjeta',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 17),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildRealisticCard(tarjetaMock),
            const SizedBox(height: 32),
            const Text(
              'Estado de cuenta',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            const SizedBox(height: 16),
            _buildBalanceInfo(tarjetaMock),
            const SizedBox(height: 32),
            const Text(
              'Gestión de tarjeta',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            const SizedBox(height: 16),
            _buildActionGrid(),
          ],
        ),
      ),
    );
  }

  Widget _buildRealisticCard(Tarjeta tarjeta) {
    return AspectRatio(
      aspectRatio: 1.586, // Proporción estándar de una tarjeta de crédito
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: const LinearGradient(
            colors: [Color(0xFF1A1A1A), Color(0xFF424242)], // Look Premium/Signature
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Logo de marca de agua (Decoración)
            Positioned(
              right: -20,
              bottom: -20,
              child: Icon(Icons.credit_card, size: 150, color: Colors.white.withOpacity(0.05)),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Chip de la tarjeta
                      Container(
                        width: 45,
                        height: 35,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.yellow.shade200, Colors.yellow.shade700],
                          ),
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      const Icon(Icons.contactless_outlined, color: Colors.white70, size: 28),
                    ],
                  ),
                  const Spacer(),
                  // Número enmascarado
                  Text(
                    tarjeta.numeroEnmascarado,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      letterSpacing: 2,
                      fontFamily: 'Courier',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('TITULAR', style: TextStyle(color: Colors.white54, fontSize: 9)),
                          Text(tarjeta.titular, style: const TextStyle(color: Colors.white, fontSize: 14)),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text('VISA', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontStyle: FontStyle.italic, fontSize: 20)),
                          Text(tarjeta.tipo.split(' ')[1], style: const TextStyle(color: Colors.white70, fontSize: 10)),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBalanceInfo(Tarjeta tarjeta) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE0E0E0)),
      ),
      child: Column(
        children: [
          _rowInfo('Límite de línea', 'S/ ${tarjeta.limiteTotal.toStringAsFixed(2)}'),
          const Divider(height: 30),
          _rowInfo('Disponible', 'S/ ${tarjeta.limiteDisponible.toStringAsFixed(2)}', color: Colors.green),
          const Divider(height: 30),
          _rowInfo('Consumo actual', 'S/ ${tarjeta.limiteUtilizado.toStringAsFixed(2)}', color: Colors.red),
          const SizedBox(height: 20),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: tarjeta.porcentajeUtilizado / 100,
              backgroundColor: Colors.grey.shade200,
              color: const Color(0xFFEC111A),
              minHeight: 8,
            ),
          ),
        ],
      ),
    );
  }

  Widget _rowInfo(String label, String value, {Color? color}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(color: Colors.grey.shade600, fontSize: 14)),
        Text(value, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: color ?? Colors.black87)),
      ],
    );
  }

  Widget _buildActionGrid() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 4,
      mainAxisSpacing: 10,
      children: [
        _actionIcon(Icons.lock_outline, 'Bloquear'),
        _actionIcon(Icons.credit_card_off_outlined, 'Congelar'),
        _actionIcon(Icons.password_outlined, 'Ver PIN'),
        _actionIcon(Icons.settings_outlined, 'Ajustes'),
      ],
    );
  }

  Widget _actionIcon(IconData icon, String label) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: const Color(0xFF005EB8).withOpacity(0.1),
          child: Icon(icon, color: const Color(0xFF005EB8)),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(fontSize: 11, color: Colors.black87)),
      ],
    );
  }
}