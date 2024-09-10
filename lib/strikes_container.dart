import 'package:flutter/material.dart';

class StrikesContainer extends StatelessWidget {
  const StrikesContainer(this.strikes, {super.key});

  final int strikes;

  final totalStrikes = 3;

  List<Icon> generateStrikes() {
    List<Icon> strikeWidgets = [];
    // Generate strike icon widgets
    if (strikes > 0) {
      for (var i = 0; i < strikes; i++) {
        Icon strikeWidget = const Icon(
          Icons.close,
          color: Colors.red,
        );
        strikeWidgets.add(strikeWidget);
      }
    }
    // Generate non-strike icon widgets
    if ((totalStrikes - strikes) > 0) {
      for (var i = 0; i < (totalStrikes - strikes); i++) {
        Icon nonStrikeWidget = const Icon(Icons.close);
        strikeWidgets.add(nonStrikeWidget);
      }
    }
    return strikeWidgets;
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0.0,
      left: 0.0,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 15.0,
          vertical: 10.0,
        ),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 53, 6, 108),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ...generateStrikes(),
          ],
        ),
      ),
    );
  }
}
