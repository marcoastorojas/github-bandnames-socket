import 'package:flutter/material.dart';

class RoutesScreen extends StatelessWidget {
  const RoutesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FloatingActionButton(
            backgroundColor: Colors.green,
            onPressed: () {
              Navigator.pushNamed(context, 'home');
            }),
      ),
    );
  }
}
