import 'package:flutter/material.dart';

class BirthdateField extends StatelessWidget {
  final ValueNotifier<DateTime?> selectedBirthdate;
  final TextEditingController controller;
  const BirthdateField(this.selectedBirthdate, this.controller, {super.key});

  Future<void> _pickBirthdate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      selectedBirthdate.value = picked;
      controller.text = picked.toLocal().toString().split(' ')[0];
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<DateTime?>(
      valueListenable: selectedBirthdate,
      builder: (context, value, _) {
        return TextFormField(
          controller: controller,
          readOnly: true,
          decoration: InputDecoration(
            labelText: 'Birthdate',
            labelStyle: Theme.of(context).textTheme.bodyMedium,
            border: buildUnderlineInputBorder(Colors.blueGrey.shade50),
            enabledBorder: buildUnderlineInputBorder(Colors.blueGrey.shade100),
            focusedBorder: buildUnderlineInputBorder(Colors.blueGrey.shade800),
            errorBorder: buildUnderlineInputBorder(Colors.red),
          ),
          onTap: () => _pickBirthdate(context),
          validator: (value) => value == null || value.isEmpty
              ? 'Please select your birthdate'
              : null,
          style: Theme.of(context).textTheme.titleMedium,
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
