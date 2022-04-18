import 'package:flutter/material.dart';
import 'package:game/game_controller.dart';
import 'package:provider/provider.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Consumer<GameController>(builder: (context, controller, child) {
        return Column(
          children: [
            Expanded(
              child: GestureDetector(
                onVerticalDragUpdate: controller.onVerticalDragUpdate,
                onHorizontalDragUpdate: controller.onHorizontalDragUpdate,
                child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 20,
                            crossAxisSpacing: 4,
                            mainAxisSpacing: 4),
                    itemBuilder: (context, index) {
                      if (controller.snakePositions.contains(index)) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: const ColoredBox(
                            color: Colors.white,
                          ),
                        );
                      } else if (index == controller.food) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: const ColoredBox(
                            color: Colors.green,
                          ),
                        );
                      } else {
                        return const ColoredBox(
                          color: Colors.black,
                        );
                      }
                    },
                    itemCount: controller.gridCount),
              ),
            ),
            TextButton(
                onPressed: () => controller.startGame(context), child: const Text('Start'))
          ],
        );
      }),
    );
  }
}
