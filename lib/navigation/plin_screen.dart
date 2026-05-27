import 'package:flutter/material.dart';

class PlinScreen extends StatelessWidget {
  const PlinScreen({super.key});

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
          'Enviar dinero con Plin',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Envía dinero al instante a cualquier banco afiliado a Plin.',
              style: TextStyle(fontSize: 15, color: Colors.grey),
            ),
            const SizedBox(height: 24),
            _buildTextField(
              context,
              label: 'Número de celular del destinatario',
              hintText: 'Ej. 987654321',
              keyboardType: TextInputType.phone,
              icon: Icons.phone_android,
            ),
            const SizedBox(height: 16),
            _buildTextField(
              context,
              label: 'Monto a enviar',
              hintText: 'S/ 0.00',
              keyboardType: TextInputType.number,
              icon: Icons.attach_money,
            ),
            const SizedBox(height: 16),
            _buildTextField(
              context,
              label: 'Concepto (opcional)',
              hintText: 'Ej. Pago de almuerzo',
              keyboardType: TextInputType.text,
              icon: Icons.description_outlined,
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  // Lógica para enviar dinero con Plin
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Funcionalidad Plin en desarrollo')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFEC111A), // Rojo Scotiabank
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Enviar con Plin',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(BuildContext context, {required String label, required String hintText, required TextInputType keyboardType, required IconData icon}) {
    return TextField(
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        prefixIcon: Icon(icon, color: Colors.grey[600]),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFEC111A), width: 2)),
      ),
    );
  }
}