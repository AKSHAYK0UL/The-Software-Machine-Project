import 'package:flutter/material.dart';

class GenderDropdown extends StatelessWidget {
  GenderDropdown(this.selectedGender, {super.key});
  final ValueNotifier<String?> selectedGender;
  final List<String> genders = ['Male', 'Female', 'Other'];

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String?>(
      valueListenable: selectedGender,
      builder: (context, value, _) {
        return DropdownButtonFormField<String>(
          decoration: InputDecoration(
            labelText: 'Gender',
            labelStyle: Theme.of(context).textTheme.bodyMedium,
            border: buildUnderlineInputBorder(Colors.blueGrey.shade50),
            enabledBorder: buildUnderlineInputBorder(Colors.blueGrey.shade100),
            focusedBorder: buildUnderlineInputBorder(Colors.blueGrey.shade800),
            errorBorder: buildUnderlineInputBorder(Colors.red),
          ),
          value: value,
          items: genders.map((gender) {
            return DropdownMenuItem(
                value: gender,
                child: Text(gender,
                    style: Theme.of(context).textTheme.titleMedium));
          }).toList(),
          onChanged: (newValue) {
            selectedGender.value = newValue;
          },
          validator: (value) =>
              value == null ? 'Please select your gender' : null,
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
