import 'package:flutter/material.dart';

class DatosPersonalesScreen extends StatelessWidget {
  const DatosPersonalesScreen({super.key});

  void _showEditMessage(BuildContext context, String field) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('La edición de $field estará disponible pronto')),
    );
  }

  @override
  Widget build(BuildContext context) {
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
          'Datos personales',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        children: [
          _buildDataCard(
            title: 'Correo electrónico',
            content: Row(
              children: [
                const Icon(
                  Icons.error_outline_rounded,
                  color: Color(0xFFEC111A), // Rojo Scotiabank
                  size: 18,
                ),
                const SizedBox(width: 8),
                const Text(
                  'ho**@gmail.com',
                  style: TextStyle(fontSize: 15, color: Colors.black87),
                ),
              ],
            ),
            onEdit: () => _showEditMessage(context, 'correo'),
          ),
          _buildDataCard(
            title: 'Número de celular',
            content: const Text(
              '******321',
              style: TextStyle(fontSize: 15, color: Colors.black87),
            ),
            onEdit: () => _showEditMessage(context, 'celular'),
          ),
          _buildDataCard(
            title: 'Dirección de domicilio',
            content: const Text(
              'Ca. Agustin Gamarra, Nro. 123, Dpto. 380, Urb. Ernesto Madelengoitia, San Juan de Miraflores, Lima',
              style: TextStyle(
                fontSize: 15,
                color: Colors.black87,
                height: 1.4,
              ),
            ),
            onEdit: () => _showEditMessage(context, 'dirección'),
          ),
          _buildDataCard(
            title: 'Ocupación principal',
            content: const Text(
              'Trabajo para una empresa, como Ingeniero.',
              style: TextStyle(fontSize: 15, color: Colors.black87),
            ),
            onEdit: () => _showEditMessage(context, 'ocupación'),
          ),
          const SizedBox(height: 24),
          // Sección de última actualización en la parte inferior
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.access_time_rounded, size: 18, color: Colors.grey[600]),
              const SizedBox(width: 8),
              Text(
                'Última actualización 19 jul. 2024, 10:00 am.',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Widget reutilizable para las tarjetas de datos solicitadas
  Widget _buildDataCard({
    required String title, 
    required Widget content,
    VoidCallback? onEdit,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE0E0E0), width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 10),
                content,
              ],
            ),
          ),
          IconButton(
            onPressed: onEdit,
            icon: const Icon(
              Icons.edit_outlined,
              color: Color(0xFF005EB8),
              size: 22,
            ),
          ),
        ],
      ),
    );
  }
}