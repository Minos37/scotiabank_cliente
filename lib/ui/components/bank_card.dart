import 'package:flutter/material.dart';

class BankCard extends StatelessWidget {
  final String titulo;
  final String? numero;
  final double? saldo;
  final String? estado;
  final Color? colorFondo;

  const BankCard({
    super.key,
    required this.titulo,
    this.numero,
    this.saldo,
    this.estado,
    this.colorFondo,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: colorFondo ?? Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            titulo,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          if (numero != null) ...[
            const SizedBox(height: 8),
            Text(
              numero!,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
          if (saldo != null) ...[
            const SizedBox(height: 16),
            Text(
              'Saldo: \$${saldo?.toStringAsFixed(2)}',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Colors.red,
                  ),
            ),
          ],
        ],
      ),
    );
  }
}
