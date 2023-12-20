import 'package:flutter/material.dart';

class Indicator {
  late BoxDecoration _dot;
  late Color _unselectedColour;
  late Color _selectedColour;

  void setSelected(bool selected) {
    print(
        "selected: $selected, colour: ${_selectedColour}, ${_unselectedColour}, ${_dot.color}");
    _dot = _dot.copyWith(color: selected ? _selectedColour : _unselectedColour);
  }

  BoxDecoration getDot() => _dot;

  Indicator({required Color selectedColour, required BoxDecoration dot}) {
    _selectedColour = selectedColour;
    _unselectedColour = dot.color!;
    _dot = dot;
  }
}
