# Estructura del Proyecto - Scotiabank Clientes

Este proyecto sigue una arquitectura MVVM (Model-View-ViewModel) con separación clara de responsabilidades.

## Estructura de Carpetas

```
lib/
├── data/                        ← Capa MODEL (Datos)
│   ├── model/                   ← Clases de datos puras
│   │   ├── auth_models.dart     ← Modelos de autenticación
│   │   ├── cuenta_models.dart   ← Modelos de cuentas
│   │   ├── tarjeta_models.dart  ← Modelos de tarjetas
│   │   └── prestamo_models.dart ← Modelos de préstamos
│   ├── remote/                  ← Comunicación con APIs
│   │   ├── auth_api.dart
│   │   ├── cuenta_api.dart
│   │   ├── tarjeta_api.dart
│   │   └── prestamo_api.dart
│   └── repository/              ← Intermediario entre ViewModel y API
│       ├── auth_repository.dart
│       ├── cuenta_repository.dart
│       ├── tarjeta_repository.dart
│       └── prestamo_repository.dart
│
├── navigation/                  ← Sistema de navegación
│   ├── screen.dart              ← Definición de rutas
│   └── nav_graph.dart           ← Configuración de navegación
│
├── ui/                          ← Capa VIEW (Interfaz de Usuario)
│   ├── components/              ← Componentes reutilizables
│   │   ├── app_scaffold.dart
│   │   ├── bank_card.dart
│   │   ├── bottom_nav_bar.dart
│   │   ├── movimiento_item.dart
│   │   └── quick_actions.dart
│   ├── screens/                 ← Pantallas completas
│   │   ├── splash_screen.dart
│   │   ├── login_screen.dart
│   │   ├── home_screen.dart
│   │   ├── cuenta_screen.dart
│   │   ├── tarjeta_screen.dart
│   │   ├── prestamo_screen.dart
│   │   ├── operaciones_screen.dart
│   │   ├── notificaciones_screen.dart
│   │   ├── contacto_screen.dart
│   │   └── perfil_screen.dart
│   ├── theme/                   ← Identidad visual
│   │   ├── color.dart           ← Paleta de colores
│   │   ├── type.dart            ← Tipografía
│   │   └── theme.dart           ← Tema global
│   └── viewmodel/               ← Capa VIEWMODEL (Lógica)
│       ├── ui_state.dart        ← Estados de UI
│       ├── auth_viewmodel.dart
│       ├── home_viewmodel.dart
│       ├── cuenta_viewmodel.dart
│       ├── tarjeta_viewmodel.dart
│       ├── prestamo_viewmodel.dart
│       └── opera_viewmodel.dart
│
└── main.dart                    ← Punto de entrada

```

## Patrones Arquitectónicos

### 1. **Model (Datos)**
- **`data/model/`**: Clases de datos puras (POJO)
- **`data/remote/`**: APIs y servicios HTTP
- **`data/repository/`**: Intermediarios entre ViewModels y APIs

### 2. **ViewModel (Lógica)**
- **`ui/viewmodel/`**: Maneja la lógica de negocio
- Extiende `ChangeNotifier` para notificar cambios
- Maneja estados de UI mediante `UiState`

### 3. **View (UI)**
- **`ui/screens/`**: Pantallas completas
- **`ui/components/`**: Widgets reutilizables
- **`ui/theme/`**: Definiciones de estilo y colores

### 4. **Navigation**
- **`navigation/`**: Define rutas y configuración de navegación
- Sistema centralizado de rutas

## Flujo de Datos

```
UI (Screen) 
    ↓
ViewModel (Lógica)
    ↓
Repository (Intermediario)
    ↓
API (Remote)
```

## Cómo Usar

### Crear una nueva pantalla

1. Crear archivo en `ui/screens/nueva_screen.dart`
2. Crear ViewModel en `ui/viewmodel/nueva_viewmodel.dart`
3. Agregar ruta en `navigation/screen.dart`
4. Agregar en `navigation/nav_graph.dart`

### Crear un nuevo modelo

1. Crear clase en `data/model/nuevo_models.dart`
2. Crear API en `data/remote/nuevo_api.dart`
3. Crear Repository en `data/repository/nuevo_repository.dart`

### Usar un ViewModel en una Screen

```dart
final viewModel = Provider.of<AuthViewModel>(context);
viewModel.login('usuario', 'contraseña');
```

## Características

- ✅ Separación de responsabilidades
- ✅ Reutilización de componentes
- ✅ Gestión centralizada de estados
- ✅ Tema visual consistente
- ✅ Sistema de navegación robusto
- ✅ Modelos tipados

## Próximos pasos

- [ ] Integrar Provider para inyección de dependencias
- [ ] Agregar persistencia local (Hive/SQLite)
- [ ] Implementar autenticación real
- [ ] Agregar pruebas unitarias
- [ ] Configurar integración con APIs reales
