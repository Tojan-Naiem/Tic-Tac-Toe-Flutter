import 'package:flutter/material.dart';

class TicTacToe extends StatefulWidget {
  const TicTacToe({super.key});

  @override
  State<TicTacToe> createState() => _TicTacToeState();
}

class _TicTacToeState extends State<TicTacToe> {
  List<String> elements = ['', '', '', '', '', '', '', '', '', ''];
  bool turnX = true;
  int numbersOfXandO = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/Sky.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 170,
            ),
            Row(
              //For the title
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'It\'s  ',style: TextStyle(fontSize: 30, color: Colors.white),
                ),
                Text(
                  turnX ? 'X' : 'O', style: TextStyle(color: Colors.yellow, fontSize: 30),
                ),
                const Text(
                  ' turn', style: TextStyle(fontSize: 30, color: Colors.white),
                ),
              ],
            ),
            
            Container(
                child: GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 9,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    _tapped(index);
                  },
                  child: Container(
                    height: 50,
                    margin:
                        EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(20),
                
                      color: Color.fromRGBO(0, 0, 0, 0.6),
                    ),
                    child: Align(
                      child: Text(elements[index],
                          style: TextStyle(fontSize: 50, color: Colors.white)),
                    ),
                  ),
                );
              },
            )),
            const SizedBox(height: 30),
            ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.yellow,
                ),
                onPressed: () {
                  setState(() {
                    _playAgain();
                  });
                },
                icon: const Icon(
                  Icons.refresh,
                  color: Colors.black,
                ),
                label: Text(
                  'Play again',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                )),
          ],
        ),
      ),
    );
  }

  void _tapped(int index) {
    setState(() {
      if (elements[index] == '') {
        turnX ? elements[index] = 'X' : elements[index] = 'O';
        turnX = !turnX;
        numbersOfXandO++;
        _checkWinner();
      }
    });
  }

  void _checkWinner() {
    for (int i = 0; i < elements.length; i += 3) {
      if (i != elements.length - 3) {
        if (elements[i] != '' &&
            elements[i] == elements[i + 1] &&
            elements[i] == elements[i + 2]) {
          _showDialog(0);
        }
      }
    }
    for (int i = 0; i < 3; i++) {
      if (elements[i] != '' &&
          elements[i] == elements[i + 3] &&
          elements[i] == elements[i + 6]) {
        _showDialog(0);
      }
    }
    if (elements[0] != '' &&
        elements[0] == elements[4] &&
        elements[0] == elements[8]) {
      _showDialog(0);
    }
    if (elements[2] != '' &&
        elements[2] == elements[4] &&
        elements[2] == elements[6]) {
      _showDialog(0);
    }
    if (numbersOfXandO == 9) {
      _showDialog(1);
    }
  }

  void _showDialog(int x) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(


            title: Align(
              child: Text(
                x == 0 ? turnX? 'O is Winner!!': 'X is Winner!!': 'Draw!',
                style:const TextStyle(
                    fontSize: 25,
                    color: Colors.red,
                    fontWeight: FontWeight.bold),
              ),
            ),
            actions: [
              TextButton(
                child: const Text("Play Again",style: TextStyle(color: Color.fromARGB(255, 0, 20, 36)),),
                onPressed: () {
                  _playAgain();
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  void _playAgain() {
    setState(() {
      elements = ['', '', '', '', '', '', '', '', '', ''];
      turnX = true;
      numbersOfXandO = 0;
    });
  }
}
