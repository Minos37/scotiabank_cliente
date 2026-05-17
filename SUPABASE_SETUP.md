# Configuración de Supabase para Scotiabank Clientes

## Información del Proyecto
- **URL**: https://hvczqkxylhwkhqexqrkk.supabase.co
- **Clave Anónima**: sb_publishable_2qxSRjnm0mo5VPbDkVbOkQ_NjACig7W

## Pasos para Completar la Configuración

### 1. Crear las Tablas en Supabase

1. Ve a tu dashboard de Supabase: https://app.supabase.com/
2. Selecciona tu proyecto **scotiabank_clientes**
3. Ve a **SQL Editor** en el panel izquierdo
4. Copia todo el contenido del archivo `database_schema.sql`
5. Pega el SQL en el editor
6. Presiona el botón de "Ejecutar" (Run)

Esto creará todas las tablas necesarias:
- `users` - Usuarios autenticados
- `cuentas` - Cuentas bancarias
- `tarjetas` - Tarjetas de crédito/débito
- `prestamos` - Préstamos activos
- `movimientos` - Historial de transacciones

### 2. Verificar que las Tablas se Crearon

1. En el panel izquierdo, ve a **Database** → **Tables**
2. Deberías ver todas las tablas listadas

### 3. Configurar Autenticación (Opcional pero Recomendado)

1. Ve a **Authentication** en el panel izquierdo
2. Ve a **Providers**
3. Habilita los proveedores que desees (Email/Password está habilitado por defecto)

### 4. Instalar Dependencias en Flutter

```bash
flutter pub get
```

Esto instalará:
- `supabase_flutter: ^2.5.0` - Cliente de Supabase
- `provider: ^6.1.0` - Gestión de estado
- `http: ^1.1.0` - Llamadas HTTP

### 5. Usar los Servicios en tu App

#### Para Autenticación:
```dart
import 'package:scotiabank_clientes/data/local/auth_service.dart';

// Registrarse
await AuthService.signUp('user@example.com', 'password123');

// Iniciar sesión
await AuthService.signIn('user@example.com', 'password123');

// Cerrar sesión
await AuthService.signOut();

// Obtener usuario actual
String? userId = AuthService.getCurrentUserId();
```

#### Para Cuentas:
```dart
import 'package:scotiabank_clientes/data/local/cuenta_service.dart';

// Obtener todas las cuentas
List<Cuenta> cuentas = await CuentaService.obtenerCuentas();

// Obtener una cuenta específica
Cuenta cuenta = await CuentaService.obtenerCuentaPorId('id-uuid');

// Crear cuenta
await CuentaService.crearCuenta(nueva_cuenta);

// Actualizar cuenta
await CuentaService.actualizarCuenta('id-uuid', cuenta_actualizada);

// Eliminar cuenta
await CuentaService.eliminarCuenta('id-uuid');
```

#### Para Tarjetas:
```dart
import 'package:scotiabank_clientes/data/local/tarjeta_service.dart';

List<Tarjeta> tarjetas = await TarjetaService.obtenerTarjetas();
// Similares a CuentaService...
```

#### Para Préstamos:
```dart
import 'package:scotiabank_clientes/data/local/prestamo_service.dart';

List<Prestamo> prestamos = await PrestamoService.obtenerPrestamos();
// Similares a CuentaService...
```

### 6. Actualizar Modelos (Si es Necesario)

Si tus modelos existentes no tienen los métodos `fromJson()` y `toJson()`, actualiza:
- `lib/data/model/auth_models.dart`
- `lib/data/model/cuenta_models.dart`
- `lib/data/model/tarjeta_models.dart`
- `lib/data/model/prestamo_models.dart`

Ejemplo:
```dart
class Cuenta {
  final String id;
  final String numeroCuenta;
  final double saldo;
  
  Cuenta({
    required this.id,
    required this.numeroCuenta,
    required this.saldo,
  });

  factory Cuenta.fromJson(Map<String, dynamic> json) {
    return Cuenta(
      id: json['id'],
      numeroCuenta: json['numero_cuenta'],
      saldo: json['saldo'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'numero_cuenta': numeroCuenta,
      'saldo': saldo,
    };
  }
}
```

### 7. Integración con ViewModels (Próximo Paso)

Los ViewModels deberán usar estos servicios:

```dart
class CuentaViewModel extends ChangeNotifier {
  List<Cuenta> _cuentas = [];
  
  List<Cuenta> get cuentas => _cuentas;

  Future<void> cargarCuentas() async {
    try {
      _cuentas = await CuentaService.obtenerCuentas();
      notifyListeners();
    } catch (e) {
      print('Error: $e');
    }
  }
}
```

## Seguridad (RLS - Row Level Security)

Las políticas de RLS ya están configuradas en el SQL. Esto significa:
- ✅ Cada usuario solo puede ver sus propios datos
- ✅ Solo pueden modificar sus propios datos
- ✅ La base de datos aplica estas restricciones automáticamente

## Próximos Pasos

1. ✅ Crear tablas en Supabase (ejecutar SQL)
2. ✅ Instalar dependencias (`flutter pub get`)
3. ⏳ Actualizar modelos con `fromJson()` y `toJson()`
4. ⏳ Integrar servicios con los ViewModels existentes
5. ⏳ Implementar UI para login/registro
6. ⏳ Hacer llamadas a los servicios desde las pantallas

## Troubleshooting

### Error: "Supabase not initialized"
- Asegúrate de que `SupabaseService.initialize()` se ejecutó en `main()` antes de `runApp()`

### Error: "Row level security violation"
- El usuario no está autenticado o intenta acceder a datos de otro usuario
- Verifica que `auth.uid()` coincida con el `user_id` en la tabla

### Error: "Table does not exist"
- No ejecutaste el SQL en Supabase
- Ve a SQL Editor y ejecuta todo el contenido de `database_schema.sql`

## Recursos Útiles

- [Documentación de Supabase Flutter](https://supabase.com/docs/reference/dart/introduction)
- [Supabase Dashboard](https://app.supabase.com/)
- [RLS Policies](https://supabase.com/docs/guides/auth/row-level-security)
