import 'package:flutter/material.dart';

class OperacionesScreen extends StatefulWidget {
  const OperacionesScreen({super.key});

  @override
  State<OperacionesScreen> createState() => _OperacionesScreenState();
}

class _OperacionesScreenState extends State<OperacionesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Operaciones')),
      body: const Center(child: Text('OperacionesScreen')),
    );
  }
}
