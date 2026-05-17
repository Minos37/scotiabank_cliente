import 'package:flutter/material.dart';

class PrestamoScreen extends StatefulWidget {
  const PrestamoScreen({super.key});

  @override
  State<PrestamoScreen> createState() => _PrestamoScreenState();
}

class _PrestamoScreenState extends State<PrestamoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Préstamos')),
      body: const Center(child: Text('PrestamoScreen')),
    );
  }
}
