class Tarjeta {
  final String id;
  final String numero;
  final String tipo;
  final String titular;
  final DateTime fechaVencimiento;
  final String estado;
  final double limiteDisponible;
  final double limiteTotal;

  Tarjeta({
    required this.id,
    required this.numero,
    required this.tipo,
    required this.titular,
    required this.fechaVencimiento,
    required this.estado,
    required this.limiteDisponible,
    required this.limiteTotal,
  });

  factory Tarjeta.fromJson(Map<String, dynamic> json) {
    return Tarjeta(
      id: json['id'] as String,
      numero: json['numero'] as String,
      tipo: json['tipo'] as String,
      titular: json['titular'] as String,
      fechaVencimiento: DateTime.parse(json['fechaVencimiento'] as String),
      estado: json['estado'] as String,
      limiteDisponible: (json['limiteDisponible'] as num).toDouble(),
      limiteTotal: (json['limiteTotal'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'numero': numero,
      'tipo': tipo,
      'titular': titular,
      'fechaVencimiento': fechaVencimiento.toIso8601String(),
      'estado': estado,
      'limiteDisponible': limiteDisponible,
      'limiteTotal': limiteTotal,
    };
  }

  String get numeroEnmascarado => '**** **** **** ${numero.substring(numero.length - 4)}';
  double get limiteUtilizado => limiteTotal - limiteDisponible;
  double get porcentajeUtilizado => (limiteUtilizado / limiteTotal) * 100;
}
