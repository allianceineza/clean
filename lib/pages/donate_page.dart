import 'package:flutter/material.dart';

class DonatePage extends StatelessWidget {
  const DonatePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Donate'),
        backgroundColor: Colors.teal,
      ),
      body: const Center(
        child: Text('Donate Page'),
      ),
    );
  }
}
