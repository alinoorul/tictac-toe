import 'package:flutter/material.dart';

import 'dart:math';
import 'dart:async';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 10),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => AfterSplash())));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Image.asset('assets/images/Frame 16.png'),
          SizedBox(
            height: 10.0,
          ),
          Text(
            "#",
            style: TextStyle(
              color: Colors.black,
              fontSize: 80.0,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            "BORED",
            style: TextStyle(
              color: Colors.black,
              fontSize: 40.0,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class AfterSplash extends StatefulWidget {
  @override
  _AfterSplashState createState() => _AfterSplashState();
}

class _AfterSplashState extends State<AfterSplash> {
  bool oTurn = true;

// 1st player is O
  List<String> displayElement = ['', '', '', '', '', '', '', '', ''];
  int oScore = 0;
  int xScore = 0;
  int filledBoxes = 0;
  Random random = new Random();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Player TIC TAC',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        Text(
                          xScore.toString(),
                          style: TextStyle(fontSize: 20, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('Player TOE',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                        Text(
                          oScore.toString(),
                          style: TextStyle(fontSize: 20, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
                color: Colors.white,
                child: GridView.builder(
                    itemCount: 9,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3),
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          _tapped(index);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black)),
                          child: Center(
                            child: displayElement[index] == 'O'
                                ? Image.asset('assets/images/Frame 2.png')
                                : displayElement[index] == 'X'
                                    ? Image.asset('assets/images/Frame 5.png')
                                    : null,
                          ),
                        ),
                      );
                    })),
          ),
          Text(
            "FOR 👣FEET lubers❤ with good breath💨",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 30.0, color: Colors.red, fontWeight: FontWeight.bold),
          ),
          Expanded(
              child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  color: Colors.indigo[50],
                  textColor: Colors.black,
                  onPressed: _clearScoreBoard,
                  child: Text("Clear Score Board"),
                ),
              ],
            ),
          )),
          Text(
            "Inspired by RICK&MORTY",
            style: TextStyle(fontSize: 18.0),
          )
        ],
      ),
    );
  }

  void _tapped(int index) {
    setState(() {
      if (oTurn && displayElement[index] == '') {
        displayElement[index] = 'O';
        filledBoxes++;
      } else if (!oTurn && displayElement[index] == '') {
        displayElement[index] = 'X';
        filledBoxes++;
      }

      oTurn = !oTurn;
      _checkWinner();
    });
  }

  void _checkWinner() {
    // Checking rows
    if (displayElement[0] == displayElement[1] &&
        displayElement[0] == displayElement[2] &&
        displayElement[0] != '') {
      _showWinDialog(displayElement[0]);
    }
    if (displayElement[3] == displayElement[4] &&
        displayElement[3] == displayElement[5] &&
        displayElement[3] != '') {
      _showWinDialog(displayElement[3]);
    }
    if (displayElement[6] == displayElement[7] &&
        displayElement[6] == displayElement[8] &&
        displayElement[6] != '') {
      _showWinDialog(displayElement[6]);
    }

    // Checking Column
    if (displayElement[0] == displayElement[3] &&
        displayElement[0] == displayElement[6] &&
        displayElement[0] != '') {
      _showWinDialog(displayElement[0]);
    }
    if (displayElement[1] == displayElement[4] &&
        displayElement[1] == displayElement[7] &&
        displayElement[1] != '') {
      _showWinDialog(displayElement[1]);
    }
    if (displayElement[2] == displayElement[5] &&
        displayElement[2] == displayElement[8] &&
        displayElement[2] != '') {
      _showWinDialog(displayElement[2]);
    }

    // Checking Diagonal
    if (displayElement[0] == displayElement[4] &&
        displayElement[0] == displayElement[8] &&
        displayElement[0] != '') {
      _showWinDialog(displayElement[0]);
    }
    if (displayElement[2] == displayElement[4] &&
        displayElement[2] == displayElement[6] &&
        displayElement[2] != '') {
      _showWinDialog(displayElement[2]);
    } else if (filledBoxes == 9) {
      _showDrawDialog();
    }
  }

  void _showWinDialog(String winner) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: winner == 'O'
                ? Text("\" " + "TOE" + " \" is Winner!!!")
                : Text("\" " + "TICTAC" + " \" is Winner!!!"),
            actions: [
              FlatButton(
                child: Text("Play Again"),
                onPressed: () {
                  _clearBoard();
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });

    if (winner == 'O') {
      oScore++;
    } else if (winner == 'X') {
      xScore++;
    }
  }

  void _showDrawDialog() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Draw"),
            actions: [
              FlatButton(
                child: Text("Play Again"),
                onPressed: () {
                  _clearBoard();
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  void _clearBoard() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        displayElement[i] = '';
      }
    });

    filledBoxes = 0;
  }

  void _clearScoreBoard() {
    setState(() {
      xScore = 0;
      oScore = 0;
      for (int i = 0; i < 9; i++) {
        displayElement[i] = '';
      }
    });
    filledBoxes = 0;
  }
}
