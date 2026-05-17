import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'navigation/nav_graph.dart';
import 'ui/theme/theme.dart';
import 'ui/viewmodel/auth_viewmodel.dart';
import 'data/supabase_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SupabaseService.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
      ],
      child: MaterialApp(
        title: 'Scotiabank',
        theme: AppTheme.lightTheme,
        onGenerateRoute: AppNavigator.generateRoute,
        initialRoute: '/splash',
      ),
    );
  }
}
