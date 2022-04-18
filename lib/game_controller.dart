import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class GameController extends ChangeNotifier {
  List<int> snakePositions = <int>[45, 65, 85, 105, 125];
  int gridCount = 760;
  static var randomNumber = Random();
  int food = randomNumber.nextInt(700);
  generateNewFood() {
    food = randomNumber.nextInt(700);
  }

  startGame(context) {
    snakePositions = <int>[45, 65, 85, 105, 125];
    const duration = Duration(milliseconds: 300);
    Timer.periodic(duration, (timer) {
      _updateSnake();
      if (gameOver()) {
        timer.cancel();
        _showGameOverScreen(context);
      }
    });
  }

  void _showGameOverScreen(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Game Over'),
            content: Text('Your Score is ${snakePositions.length}'),
            actions: <Widget>[
              TextButton(
                child: const Text('Play Again'),
                onPressed: () {
                  Navigator.of(context).pop();
                  startGame(context);
                },
              ),
            ],
          );
        });
  }

  var direction = 'down';
  _updateSnake() {
    switch (direction) {
      case 'down':
        if (snakePositions.last > 740) {
          snakePositions.add(snakePositions.last + 20 - 760);
        } else {
          snakePositions.add(snakePositions.last + 20);
        }

        break;
      case 'up':
        if (snakePositions.last < 20) {
          snakePositions.add(snakePositions.last - 20 + 760);
        } else {
          snakePositions.add(snakePositions.last - 20);
        }

        break;
      case 'left':
        if (snakePositions.last % 20 == 0) {
          snakePositions.add(snakePositions.last + 20 - 1);
        } else {
          snakePositions.add(snakePositions.last - 1);
        }

        break;
      case 'right':
        if ((snakePositions.last + 1) % 20 == 0) {
          snakePositions.add(snakePositions.last + 1 - 20);
        } else {
          snakePositions.add(snakePositions.last + 1);
        }

        break;
      default:
    }
    if (snakePositions.last == food) {
      generateNewFood();
    } else {
      snakePositions.removeAt(0);
    }
    notifyListeners();
  }

  onVerticalDragUpdate(details) {
    if (direction != 'up' && details.delta.dy > 0) {
      direction = 'down';
    } else if (direction != 'down' && details.delta.dy < 0) {
      direction = 'up';
    }
  }

  onHorizontalDragUpdate(details) {
    if (direction != 'left' && details.delta.dx > 0) {
      direction = 'right';
    } else if (direction != 'right' && details.delta.dx < 0) {
      direction = 'left';
    }
  }

  bool gameOver() {
    for (int i = 0; i < snakePositions.length; i++) {
      int count = 0;
      for (int j = 0; j < snakePositions.length; j++) {
        if (snakePositions[i] == snakePositions[j]) {
          count += 1;
        }
        if (count == 2) {
          return true;
        }
      }
    }
    return false;
  }
}
