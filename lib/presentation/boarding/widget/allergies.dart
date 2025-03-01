import 'package:flutter/material.dart';

class AllergiesField extends StatelessWidget {
  final TextEditingController controller;

  const AllergiesField(this.controller, {super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: 'Allergies (if any)',
        labelStyle: Theme.of(context).textTheme.bodyMedium,
        border: buildUnderlineInputBorder(Colors.blueGrey.shade50),
        enabledBorder: buildUnderlineInputBorder(Colors.blueGrey.shade100),
        focusedBorder: buildUnderlineInputBorder(Colors.blueGrey.shade800),
        errorBorder: buildUnderlineInputBorder(Colors.red),
      ),
      maxLines: null,
    );
  }
}

UnderlineInputBorder buildUnderlineInputBorder(Color color) {
  return UnderlineInputBorder(
    borderSide: BorderSide(color: color, width: 1.5),
  );
}
