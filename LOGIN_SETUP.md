# Guía de Configuración del Login con Supabase ## Resumen de Cambios Se ha integrado completamente Supabase con el flujo de autenticación de la app. Los cambios incluyen: ### Archivos Actualizados 1. **pubspec.yaml** Agregadas dependencias: `supabase_flutter`, `provider`, `http`

Pilar 

2. **lib/main.dart**
   - Inicialización de Supabase antes de ejecutar la app
   - Agregado MultiProvider para gestión de estado con Provider

3. **lib/data/supabase_service.dart** (nuevo)
   - Servicio central que gestiona la conexión con Supabase
   - Métodos para auth, read, insert, update, delete

4. **lib/data/local/auth_service.dart** (nuevo)
   - Métodos de alto nivel: signIn, signUp, signOut, getCurrentUser

5. **lib/ui/viewmodel/auth_viewmodel.dart**
   - Integración con AuthService (Supabase)
   - Estados: UiLoading, UiSuccess, UiError, UiEmpty
   - Métodos: login(), signup(), logout(), checkAuthStatus()

6. **lib/ui/screens/login_screen.dart**
   - Nuevo campo de email
   - Integración con AuthViewModel via Provider
   - Validación de campos
   - Manejo de estados (loading, error, éxito)
   - Opción para registrarse

7. **lib/ui/screens/splash_screen.dart**
   - Chequeo automático de autenticación al iniciar
   - Redirección a /home si está autenticado
   - Redirección a /login si no está autenticado

8. **lib/ui/screens/home_screen.dart**
   - Botón de logout en el AppBar
   - Redirige a login después de logout

## Flujo de Autenticación

```
Splash Screen (2 segundos)
    ↓
¿Usuario autenticado?
    ├─ SÍ → Home Screen
    └─ NO → Login Screen
         ├─ Registrarse → signup()
         └─ Iniciar sesión → login()
            ├─ Éxito → Home Screen
            └─ Error → Mostrar mensaje
```

## Cómo Probar

### 1. Crear Tabla de Usuarios en Supabase (si no lo has hecho)

En el dashboard de Supabase, ejecuta este SQL en SQL Editor:

```sql
CREATE TABLE IF NOT EXISTS users (
  id UUID PRIMARY KEY DEFAULT auth.uid(),
  email TEXT UNIQUE NOT NULL,
  full_name TEXT,
  created_at TIMESTAMP DEFAULT now()
);

ALTER TABLE users ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can view own data" ON users
  FOR SELECT USING (auth.uid() = id);
```

### 2. Instalar Dependencias

```bash
flutter pub get
```

### 3. Ejecutar la App

```bash
flutter run
```

### 4. Flujo de Prueba

#### Opción A: Registrarse (Nuevo Usuario)

1. La app muestra el Splash Screen por 2 segundos
2. Te redirige al Login Screen
3. Completa los campos:
   - **Email**: ejemplo@email.com (debe ser válido)
   - **Contraseña**: password123 (mínimo 6 caracteres)
4. Haz clic en **"Regístrate"**
5. Si el registro es exitoso → Se abre automáticamente Home Screen
6. Si hay error → Se muestra el mensaje en rojo

#### Opción B: Iniciar Sesión (Usuario Existente)

1. En el Login Screen, completa:
   - **Email**: el email que registraste
   - **Contraseña**: la contraseña que usaste
2. Haz clic en **"Iniciar sesión"**
3. Si el login es exitoso → Se abre automáticamente Home Screen
4. Si hay error → Se muestra el mensaje en rojo

#### Prueba de Logout

1. En Home Screen, haz clic en el menú (⋮) arriba a la derecha
2. Selecciona **"Cerrar sesión"**
3. Deberías volver al Login Screen automáticamente

#### Prueba de Persistencia

1. Inicia sesión normalmente
2. Cierra la app completamente
3. Vuelve a abrir la app
4. Deberías ir directamente a Home Screen (sin mostrar Login)
5. Esto significa que la sesión se mantiene

## Estructura de Estados

La app usa un patrón UiState para manejar diferentes estados:

- **UiEmpty**: Estado inicial
- **UiLoading**: Cargando (muestra spinner en el botón)
- **UiSuccess**: Login/registro exitoso
- **UiError**: Error en auth (muestra mensaje rojo)

## Variables de Entorno

Las credenciales de Supabase están hardcodeadas en:
- `lib/data/supabase_service.dart`

Para producción, considera:
- Guardarlas en `flutter.env` o archivo de configuración
- Usar el paquete `flutter_dotenv`

## Errores Comunes

### "No implementation found for method getAll on channel plugins.flutter.io/shared_preferences"

**Solución:**
```bash
flutter clean
flutter pub get
flutter pub upgrade
```

### "Table 'users' does not exist"

**Solución:** Ejecuta el SQL en Supabase para crear la tabla de usuarios.

### "Email already registered"

**Error esperado** si intentas registrarte con un email que ya existe. Usa otro email o inicia sesión.

### "Invalid login credentials"

**Significa:** El email o contraseña es incorrecto. Verifica los datos.

### "App closed without logout"

**Solución:** Siempre usa el botón de logout en Home Screen para cerrar sesión apropiadamente.

## Próximos Pasos

1. ✅ Login funcionando
2. ⏳ Agregar recuperación de contraseña
3. ⏳ Integrar autenticación de dos factores (2FA)
4. ⏳ Integrar con Google/Apple login
5. ⏳ Agregar perfil de usuario
6. ⏳ Persistencia local con sqlite/hive

## Útiles

- [Documentación Supabase Flutter](https://supabase.com/docs/reference/dart/introduction)
- [Documentación Provider](https://pub.dev/packages/provider)
- [Flutter Auth Best Practices](https://flutter.dev/docs/development/data-and-backend/authentication)
