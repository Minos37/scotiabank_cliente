import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodel/auth_viewmodel.dart';
import '../viewmodel/ui_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _trustDevice = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin(BuildContext context) {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, completa todos los campos')),
      );
      return;
    }

    final authViewModel = Provider.of<AuthViewModel>(context, listen: false);
    authViewModel.login(_emailController.text, _passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Consumer<AuthViewModel>(
              builder: (context, authViewModel, _) {
                if (authViewModel.state is UiSuccess) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      '/home',
                      (route) => false,
                    );
                  });
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 40),

                    // Logo Scotiabank
                    Text(
                      'Scotiabank.',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                    ),

                    const SizedBox(height: 48),

                    // Avatar con inicial
                    Container(
                      width: 80,
                      height: 80,
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          'S',
                          style:
                              Theme.of(context).textTheme.displaySmall?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 32),

                    // Campo de email
                    Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.red,
                            width: 3,
                          ),
                        ),
                      ),
                      child: TextField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        enabled: authViewModel.state is! UiLoading,
                        decoration: const InputDecoration(
                          hintText: 'correo@ejemplo.com',
                          prefixIcon: Icon(Icons.email, color: Colors.grey),
                          border: InputBorder.none,
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Campo de contraseña
                    Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.red,
                            width: 3,
                          ),
                        ),
                      ),
                      child: TextField(
                        controller: _passwordController,
                        obscureText: _obscurePassword,
                        enabled: authViewModel.state is! UiLoading,
                        decoration: InputDecoration(
                          hintText: '••••••••',
                          prefixIcon: const Icon(Icons.lock, color: Colors.grey),
                          border: InputBorder.none,
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Mostrar error si existe
                    if (authViewModel.state is UiError)
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.red.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          (authViewModel.state as UiError).message,
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),

                    if (authViewModel.state is UiError)
                      const SizedBox(height: 16),

                    // ¿Olvidaste tu contraseña?
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          '¿Olvidaste tu contraseña?',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: Colors.grey[600],
                              ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Checkbox - Confiar en este dispositivo
                    Row(
                      children: [
                        Checkbox(
                          value: _trustDevice,
                          onChanged: authViewModel.state is UiLoading
                              ? null
                              : (value) {
                                  setState(() {
                                    _trustDevice = value ?? false;
                                  });
                                },
                          activeColor: Colors.deepPurple,
                        ),
                        Text(
                          'Confiar en este dispositivo',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: Colors.grey[700],
                              ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 32),

                    // Botón Iniciar sesión
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: authViewModel.state is UiLoading
                            ? null
                            : () => _handleLogin(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: authViewModel.state is UiLoading
                            ? const SizedBox(
                                height: 24,
                                width: 24,
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.white,
                                  ),
                                  strokeWidth: 2,
                                ),
                              )
                            : Text(
                                'Iniciar sesión',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge
                                    ?.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Opción para registrarse
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '¿No tienes cuenta? ',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        TextButton(
                          onPressed: authViewModel.state is UiLoading
                              ? null
                              : () {
                                  if (_emailController.text.isNotEmpty &&
                                      _passwordController.text.isNotEmpty) {
                                    authViewModel.signup(
                                      _emailController.text,
                                      _passwordController.text,
                                    );
                                  }
                                },
                          child: const Text('Regístrate'),
                        ),
                      ],
                    ),

                    const SizedBox(height: 32),

                    // Enlaces de pie de página
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.location_on,
                              color: Colors.deepPurple),
                          label: Text(
                            'Ubicanos',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                  color: Colors.deepPurple,
                                ),
                          ),
                        ),
                        TextButton.icon(
                          onPressed: () {},
                          icon:
                              const Icon(Icons.phone, color: Colors.deepPurple),
                          label: Text(
                            'Llámanos',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                  color: Colors.deepPurple,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
