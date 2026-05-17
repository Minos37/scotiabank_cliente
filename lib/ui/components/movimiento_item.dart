import 'package:flutter/material.dart';

class MovimientoItem extends StatelessWidget {
  final String titulo;
  final String concepto;
  final double monto;
  final DateTime fecha;
  final String tipo;

  const MovimientoItem({
    super.key,
    required this.titulo,
    required this.concepto,
    required this.monto,
    required this.fecha,
    required this.tipo,
  });

  @override
  Widget build(BuildContext context) {
    final isIngreso = tipo.toLowerCase() == 'ingreso';
    final color = isIngreso ? Colors.green : Colors.red;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).dividerColor,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  titulo,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  concepto,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 4),
                Text(
                  fecha.toString().split(' ')[0],
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ],
            ),
          ),
          Text(
            '${isIngreso ? '+' : '-'}\$$monto',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: color,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ],
      ),
    );
  }
}
