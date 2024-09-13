import 'package:flutter/material.dart';

class StrikesContainer extends StatelessWidget {
  const StrikesContainer(this.strikes, this.totalStrikes, {super.key});

  final int strikes;
  final int totalStrikes;

  List<Icon> generateStrikes() {
    List<Icon> strikeWidgets = [];
    // Generate red strike icon widgets
    if (strikes > 0) {
      for (var i = 0; i < strikes; i++) {
        Icon strikeWidget = const Icon(
          Icons.close,
          color: Colors.red,
        );
        strikeWidgets.add(strikeWidget);
      }
    }
    // Generate black strike icon widgets
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
            // Generate all specified strike icons and spread them in the widget
            ...generateStrikes(),
          ],
        ),
      ),
    );
  }
}
