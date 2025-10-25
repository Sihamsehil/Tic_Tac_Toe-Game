import 'package:flutter/material.dart';
import 'game.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: const Game());
  }
}

class Game extends StatelessWidget {
  const Game({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 245, 250),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 200),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset('assets/img1.jpg', height: 200, width: 200),
            ),
            const SizedBox(height: 60),
            Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 249, 232, 240),
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 8,
                    offset: const Offset(0, 4), // Shadow position (x, y)
                  ),
                ],
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 20,
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const GameScreen()),
                  );
                },
                child: const Text(
                  'Start Game',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color.fromARGB(255, 55, 65, 82),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
