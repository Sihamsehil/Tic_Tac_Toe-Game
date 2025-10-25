import 'package:flutter/material.dart';

class GameBoardScreen extends StatefulWidget {
  final String currentPlayer;
  const GameBoardScreen({super.key, required this.currentPlayer});
  @override
  State<GameBoardScreen> createState() => _GameBoardScreenState();
}

class _GameBoardScreenState extends State<GameBoardScreen> {
  List<String> board = List.filled(9, '');
  late String currentPlayer;
  @override
  void initState() {
    super.initState();
    currentPlayer = widget.currentPlayer;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 245, 250),
      appBar: AppBar(iconTheme: IconThemeData()),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Player $currentPlayer's Turn",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF374152),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: 300,
              height: 300,
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                itemCount: 9,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 6,
                  mainAxisSpacing: 6,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () => onTapped(index),
                    child: Container(
                      decoration: BoxDecoration(
                        color: (index % 2 == 0)
                            ? const Color.fromARGB(255, 255, 173, 201)
                            : const Color.fromARGB(255, 170, 240, 213),
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            blurRadius: 4,
                            offset: const Offset(2, 2),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          board[index],
                          style: TextStyle(
                            fontSize: 42,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF2A4D69),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            // Add this inside your Column in the build method, after the GridView
            const SizedBox(height: 30),
            GestureDetector(
              onTap: () {
                setState(() {
                  board = List.filled(9, '');
                  currentPlayer = widget.currentPlayer;
                });
              },

              child: const Icon(
                Icons.restart_alt_rounded,
                size: 35,
                color: const Color(0xFF2A4D69),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onTapped(int index) {
    setState(() {
      if (board[index] == '') {
        board[index] = currentPlayer;
        String? winner = checkWinner();
        if (winner != null) {
          Future.delayed(const Duration(milliseconds: 300), () {
            showGameOverDialog(context, winner);
          });
          return;
        }

        currentPlayer = (currentPlayer == 'X') ? 'O' : 'X';
      }
    });
  }

  String? checkWinner() {
    List<List<int>> winPatterns = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];
    for (var patteren in winPatterns) {
      if (board[patteren[0]] != '' &&
          board[patteren[0]] == board[patteren[1]] &&
          board[patteren[1]] == board[patteren[2]]) {
        return board[patteren[0]];
      }
    }
    if (!board.contains('')) {
      return 'Draw';
    }
    return null;
  }

  void showGameOverDialog(BuildContext context, String winner) {
    showDialog(
      context: context,
      barrierDismissible: false, // User must tap button to close
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color.fromARGB(255, 255, 245, 250),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text(
            'Game Over!',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 55, 65, 82),
            ),
            textAlign: TextAlign.center,
          ),
          content: Text(
            winner == 'Draw' ? "It's a Draw!" : 'Player $winner Wins!',
            style: const TextStyle(
              fontSize: 18,
              color: Color.fromARGB(255, 55, 65, 82),
            ),
            textAlign: TextAlign.center,
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
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
                        horizontal: 20,
                        vertical: 10,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(); // Close dialog
                      setState(() {
                        board = List.filled(9, '');
                        currentPlayer = widget.currentPlayer;
                      });
                    },
                    child: const Text(
                      'Restart',
                      style: TextStyle(
                        color: Color.fromARGB(255, 55, 65, 82),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                // Home Button
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
                        horizontal: 20,
                        vertical: 10,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(
                        context,
                      ).popUntil((route) => route.isFirst); // Go to home
                    },
                    child: const Text(
                      'Home',
                      style: TextStyle(
                        color: Color.fromARGB(255, 55, 65, 82),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
