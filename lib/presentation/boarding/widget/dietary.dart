import 'package:flutter/material.dart';

class DietaryCheckboxes extends StatelessWidget {
  final ValueNotifier<List<String>> selectedDietaryChoices;
  DietaryCheckboxes(this.selectedDietaryChoices, {super.key});
  final List<String> dietaryOptions = ['Vegan', 'Vegetarian', 'Keto', 'Halal'];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Dietary Choices',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          ValueListenableBuilder<List<String>>(
            valueListenable: selectedDietaryChoices,
            builder: (context, selected, _) {
              return Column(
                children: dietaryOptions.map((option) {
                  return CheckboxListTile(
                    contentPadding: EdgeInsets.zero,
                    fillColor: WidgetStateProperty.all(Colors.blue),
                    checkColor: Colors.white,
                    title: Text(option,
                        style: Theme.of(context).textTheme.titleMedium),
                    value: selected.contains(option),
                    onChanged: (checked) {
                      if (checked == true) {
                        selectedDietaryChoices.value = List.from(selected)
                          ..add(option);
                      } else {
                        selectedDietaryChoices.value = List.from(selected)
                          ..remove(option);
                      }
                    },
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}
