class Cuenta {
  final String id;
  final String numero;
  final String tipo;
  final String moneda;
  final double saldo;
  final String estado;
  final DateTime fechaApertura;

  Cuenta({
    required this.id,
    required this.numero,
    required this.tipo,
    required this.moneda,
    required this.saldo,
    required this.estado,
    required this.fechaApertura,
  });

  factory Cuenta.fromJson(Map<String, dynamic> json) {
    return Cuenta(
      id: json['id'] as String,
      numero: json['numero'] as String,
      tipo: json['tipo'] as String,
      moneda: json['moneda'] as String,
      saldo: (json['saldo'] as num).toDouble(),
      estado: json['estado'] as String,
      fechaApertura: DateTime.parse(json['fechaApertura'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'numero': numero,
      'tipo': tipo,
      'moneda': moneda,
      'saldo': saldo,
      'estado': estado,
      'fechaApertura': fechaApertura.toIso8601String(),
    };
  }
}

class Movimiento {
  final String id;
  final String tipo;
  final double monto;
  final String concepto;
  final DateTime fecha;
  final String estado;
  final String? referencia;

  Movimiento({
    required this.id,
    required this.tipo,
    required this.monto,
    required this.concepto,
    required this.fecha,
    required this.estado,
    this.referencia,
  });

  factory Movimiento.fromJson(Map<String, dynamic> json) {
    return Movimiento(
      id: json['id'] as String,
      tipo: json['tipo'] as String,
      monto: (json['monto'] as num).toDouble(),
      concepto: json['concepto'] as String,
      fecha: DateTime.parse(json['fecha'] as String),
      estado: json['estado'] as String,
      referencia: json['referencia'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'tipo': tipo,
      'monto': monto,
      'concepto': concepto,
      'fecha': fecha.toIso8601String(),
      'estado': estado,
      'referencia': referencia,
    };
  }
}
