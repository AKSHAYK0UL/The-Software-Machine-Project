import 'package:flutter/material.dart';

class RaceDropdown extends StatelessWidget {
  final ValueNotifier<String?> selectedRace;
  RaceDropdown(this.selectedRace, {super.key});
  final List<String> races = ['White', 'Black', 'Asian', 'Hispanic', 'Other'];

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String?>(
      valueListenable: selectedRace,
      builder: (context, value, _) {
        return DropdownButtonFormField<String>(
          decoration: InputDecoration(
            labelText: 'Race',
            labelStyle: Theme.of(context).textTheme.bodyMedium,
            border: buildUnderlineInputBorder(Colors.blueGrey.shade50),
            enabledBorder: buildUnderlineInputBorder(Colors.blueGrey.shade100),
            focusedBorder: buildUnderlineInputBorder(Colors.blueGrey.shade800),
            errorBorder: buildUnderlineInputBorder(Colors.red),
          ),
          value: value,
          items: races.map((race) {
            return DropdownMenuItem(
                value: race,
                child: Text(
                  race,
                  style: Theme.of(context).textTheme.titleMedium,
                ));
          }).toList(),
          onChanged: (newValue) {
            selectedRace.value = newValue;
          },
          validator: (value) =>
              value == null ? 'Please select your race' : null,
        );
      },
    );
  }
}

UnderlineInputBorder buildUnderlineInputBorder(Color color) {
  return UnderlineInputBorder(
    borderSide: BorderSide(color: color, width: 1.5),
  );
}
