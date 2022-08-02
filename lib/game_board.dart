import 'package:flutter/material.dart';

class GameBoard extends StatefulWidget {
  @override
  _GameBoardState createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  final List<List> matrix = <List>[];
  var player1;
  var player2;

  @override
  void initState() {
    super.initState();
    _createMatrix();
  }

  _createMatrix() {
    player1 = 0;
    player2 = 0;
    size = 0;
    matrix.clear();
    for (int i = 0; i < 3; i++) {
      final _list = [];
      for (int j = 0; j < 3; j++) {
        _list.add(' ');
      }
      matrix.add(_list);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(children: [
      //Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
          height: 100,
          padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
          child: Align(
              alignment: Alignment.center,
              child: Text(
                "Tic Tac Toe",
                textAlign: TextAlign.center,
                style: TextStyle(fontFamily: 'Sans Serif'),
              ))),
      Row(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Column(mainAxisAlignment: MainAxisAlignment.center,
                //padding: const EdgeInsets.fromLTRB(70, 100, 160, 100),
                children: [
                  Container(
                      // left top right bottom
                      padding: const EdgeInsets.fromLTRB(25, 10, 0, 0),
                      child: Text("Player O",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontFamily: 'Sans Serif'))),
                  Container(
                      padding: const EdgeInsets.fromLTRB(25, 10, 0, 70),
                      child: Text(player1.toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(fontFamily: 'Sans Serif')))
                ]),
            Column(mainAxisAlignment: MainAxisAlignment.center,
                //padding: const EdgeInsets.fromLTRB(70, 100, 160, 100),
                children: [
                  Container(
                      padding: const EdgeInsets.fromLTRB(250, 10, 0, 0),
                      child: Text(
                        "Player X",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontFamily: 'Sans Serif'),
                      )),
                  Container(
                    padding: const EdgeInsets.fromLTRB(250, 10, 0, 70),
                    child: Text(
                      player2.toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(fontFamily: 'Sans Serif'),
                    ),
                  )
                ])
          ]),
        ],
      ),
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _createCell(0, 0),
          _createCell(0, 1),
          _createCell(0, 2),
        ],
      ),
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _createCell(1, 0),
          _createCell(1, 1),
          _createCell(1, 2),
        ],
      ),
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _createCell(2, 0),
          _createCell(2, 1),
          _createCell(2, 2),
        ],
      ),
    ])));
  }

  var size = 0;
  String _lastChar = ' ';
  _createCell(int i, int j) {
    return GestureDetector(
        onTap: () {
          _changeBoard(i, j);
          _checkWinner(i, j);
          _calculateScore(i, j);
          size++;
          if (size == 9) {
            _printTieGame();
          }
        },
        child: Container(
            width: 120,
            height: 120,
            decoration: const BoxDecoration(
                color: Colors.red,
                border: Border(
                  right: BorderSide(),
                  bottom: BorderSide(),
                )),
            child: Center(
                child: Text(matrix[i][j], style: TextStyle(fontSize: 92)))));
  }

  _changeBoard(int i, int j) {
    setState(() {
      if (matrix[i][j] == ' ') {
        if (_lastChar == 'O') {
          matrix[i][j] = 'X';
        } else {
          matrix[i][j] = 'O';
        }
        _lastChar = matrix[i][j];
      }
    });
  }

  _checkWinner(int i, int j) {
    var col = 0, row = 0, diag = 0, rdiag = 0;
    //bool boolean;
    var toCheckFor = matrix[i][j];
    var length = matrix.length;
    for (int count = 0; count < matrix.length; count++) {
      if (matrix[i][count] == toCheckFor) {
        row++;
      }
      if (matrix[count][j] == toCheckFor) {
        col++;
      }
      if (matrix[count][count] == toCheckFor) {
        diag++;
      }
      if (matrix[count][matrix.length - count - 1] == toCheckFor) {
        rdiag++;
      }
    }
    if (row == length || col == length || diag == length || rdiag == length) {
      size = 0;
      if (toCheckFor == 'O') {
        _printWinner("Player O");
      } else if (toCheckFor == 'X') {
        _printWinner("Player X");
      }
    }
  }

  _calculateScore(int first, int second) {
    if (matrix[first][second] == 'O') {
      player1++;
    } else if (matrix[first][second] == 'X') {
      player2++;
    }
  }

  _printTieGame() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("It's a Tie!"),
            content: Text("Click to Play Again."),
            actions: <Widget>[
              FlatButton(
                  child: Text("Reset Button"),
                  onPressed: () {
                    Navigator.of(context).pop();
                    setState(() {
                      _createMatrix();
                    });
                  })
            ],
          );
        });
  }

  _printWinner(String winner) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Game Over'),
            content: Text("$winner won"),
            actions: <Widget>[
              FlatButton(
                child: Text("Play Again"),
                onPressed: () {
                  Navigator.of(context).pop();
                  setState(() {
                    _createMatrix();
                  });
                },
              )
            ],
          );
        });
  }
}
