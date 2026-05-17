import 'package:flutter/material.dart';

class TarjetaScreen extends StatefulWidget {
  const TarjetaScreen({super.key});

  @override
  State<TarjetaScreen> createState() => _TarjetaScreenState();
}

class _TarjetaScreenState extends State<TarjetaScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tarjetas')),
      body: const Center(child: Text('TarjetaScreen')),
    );
  }
}
