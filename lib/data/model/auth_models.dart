class AuthRequest {
  final String usuario;
  final String contrasena;

  AuthRequest({
    required this.usuario,
    required this.contrasena,
  });

  Map<String, dynamic> toJson() {
    return {
      'usuario': usuario,
      'contrasena': contrasena,
    };
  }
}

class AuthResponse {
  final String id;
  final String usuario;
  final String token;
  final String email;

  AuthResponse({
    required this.id,
    required this.usuario,
    required this.token,
    required this.email,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      id: json['id'] as String,
      usuario: json['usuario'] as String,
      token: json['token'] as String,
      email: json['email'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'usuario': usuario,
      'token': token,
      'email': email,
    };
  }
}

class Usuario {
  final String id;
  final String nombre;
  final String usuario;
  final String email;
  final String? fotoPerfil;

  Usuario({
    required this.id,
    required this.nombre,
    required this.usuario,
    required this.email,
    this.fotoPerfil,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      id: json['id'] as String,
      nombre: json['nombre'] as String,
      usuario: json['usuario'] as String,
      email: json['email'] as String,
      fotoPerfil: json['fotoPerfil'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'usuario': usuario,
      'email': email,
      'fotoPerfil': fotoPerfil,
    };
  }
}
