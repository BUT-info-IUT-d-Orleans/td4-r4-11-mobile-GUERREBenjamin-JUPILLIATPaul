import 'package:flutter/material.dart';

class SliderDifficulty extends StatefulWidget {
  final double value;
  final ValueChanged<double> onChanged;
  final String label;

  const SliderDifficulty({
    Key? key,
    required this.value,
    required this.onChanged,
    required this.label,
  }) : super(key: key);

  @override
  _SliderDifficultyState createState() => _SliderDifficultyState();
}

class _SliderDifficultyState extends State<SliderDifficulty> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          widget.label,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.green, Colors.red],
              stops: [0.0, 1.0],
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: SliderTheme(
            data: SliderThemeData(
              thumbColor: Color.fromARGB(255, 3, 0, 0),
              activeTrackColor: Colors.transparent,
              inactiveTrackColor: Colors.transparent,
              overlayColor: Colors.red.withOpacity(0.2),
              thumbShape: RoundSliderThumbShape(enabledThumbRadius: 8),
              overlayShape: RoundSliderOverlayShape(overlayRadius: 16),
              trackHeight: 4,
            ),
            child: Slider(
              value: widget.value,
              min: 1,
              max: 5,
              divisions: 4,
              onChanged: widget.onChanged,
            ),
          ),
        ),
      ],
    );
  }
}
