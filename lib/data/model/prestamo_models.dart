class Prestamo {
  final String id;
  final double montoTotal;
  final double montoPagado;
  final double montoPendiente;
  final String moneda;
  final double tasaInteres;
  final int plazoMeses;
  final int mesesPagados;
  final String estado;
  final DateTime fechaDesembolso;
  final DateTime? fechaProximaCuota;

  Prestamo({
    required this.id,
    required this.montoTotal,
    required this.montoPagado,
    required this.montoPendiente,
    required this.moneda,
    required this.tasaInteres,
    required this.plazoMeses,
    required this.mesesPagados,
    required this.estado,
    required this.fechaDesembolso,
    this.fechaProximaCuota,
  });

  factory Prestamo.fromJson(Map<String, dynamic> json) {
    return Prestamo(
      id: json['id'] as String,
      montoTotal: (json['montoTotal'] as num).toDouble(),
      montoPagado: (json['montoPagado'] as num).toDouble(),
      montoPendiente: (json['montoPendiente'] as num).toDouble(),
      moneda: json['moneda'] as String,
      tasaInteres: (json['tasaInteres'] as num).toDouble(),
      plazoMeses: json['plazoMeses'] as int,
      mesesPagados: json['mesesPagados'] as int,
      estado: json['estado'] as String,
      fechaDesembolso: DateTime.parse(json['fechaDesembolso'] as String),
      fechaProximaCuota: json['fechaProximaCuota'] != null
          ? DateTime.parse(json['fechaProximaCuota'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'montoTotal': montoTotal,
      'montoPagado': montoPagado,
      'montoPendiente': montoPendiente,
      'moneda': moneda,
      'tasaInteres': tasaInteres,
      'plazoMeses': plazoMeses,
      'mesesPagados': mesesPagados,
      'estado': estado,
      'fechaDesembolso': fechaDesembolso.toIso8601String(),
      'fechaProximaCuota': fechaProximaCuota?.toIso8601String(),
    };
  }

  double get porcentajePagado => (montoPagado / montoTotal) * 100;
}
