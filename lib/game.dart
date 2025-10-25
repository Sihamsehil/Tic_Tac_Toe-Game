import 'package:flutter/material.dart';
import 'boardScreen.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  String currentPlayer = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 245, 250),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Pick Your Side',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 55, 65, 82),
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildChoiceButton(
                  'X',
                  const Color.fromARGB(255, 255, 173, 201),
                ),
                const SizedBox(width: 30),
                _buildChoiceButton(
                  'O',
                  const Color.fromARGB(255, 170, 240, 213),
                ),
              ],
            ),

            const SizedBox(height: 50),

            if (currentPlayer.isNotEmpty)
              Text(
                'You chose $currentPlayer!',
                style: const TextStyle(
                  fontSize: 22,
                  color: Color.fromARGB(255, 55, 65, 82),
                  fontWeight: FontWeight.w500,
                ),
              ),
            const SizedBox(height: 80),
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
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                
                onPressed:  currentPlayer.isEmpty 
               ? null 
               :()  {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          GameBoardScreen(currentPlayer: currentPlayer),
                    ),
                  );
                },
                child: const Text(
                  'Continue',
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

  Widget _buildChoiceButton(String choice, Color color) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          currentPlayer = choice;
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 40),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
      child: Text(
        choice,
        style: TextStyle(
          color: Color.fromARGB(255, 55, 65, 82),
          fontSize: 40,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
