import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF508C9B),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/logo.png'),
            Text(
              'Bem-vindo ao meu App!',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            IconButton(
              icon: Icon(Icons.navigate_next, color: Colors.white, size: 50),
              onPressed: () {
                Modular.to.navigate('/main');
              },
            ),
          ],
        ),
      ),
    );
  }
}
