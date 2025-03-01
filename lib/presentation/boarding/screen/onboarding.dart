import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tsm/bloc/database_bloc/bloc/database_bloc.dart';
import 'package:tsm/core/enums/database_enum.dart';
import 'package:tsm/core/ui_component/loadingbutton.dart';
import 'package:tsm/core/ui_component/snackbar.dart';
import 'package:tsm/model/formdata.dart';
import 'package:tsm/presentation/boarding/widget/allergies.dart';
import 'package:tsm/presentation/boarding/widget/birthdate.dart';
import 'package:tsm/presentation/boarding/widget/dietary.dart';
import 'package:tsm/presentation/boarding/widget/gender.dart';
import 'package:tsm/presentation/boarding/widget/race.dart';
import 'package:tsm/presentation/home/screen/profile.dart';

class Onboarding extends StatefulWidget {
  static const routeName = "/onboarding";
  const Onboarding({super.key});
  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final _formKey = GlobalKey<FormState>();

  final ValueNotifier<String?> selectedRace = ValueNotifier(null);
  final ValueNotifier<String?> selectedGender = ValueNotifier(null);
  final ValueNotifier<DateTime?> selectedBirthdate = ValueNotifier(null);
  final ValueNotifier<List<String>> selectedDietaryChoices = ValueNotifier([]);
  final TextEditingController allergiesController = TextEditingController();
  final TextEditingController birthdateController = TextEditingController();

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate() && selectedBirthdate.value != null) {
      _formKey.currentState!.save();
      final data = FormData(
        race: selectedRace.value!,
        gender: selectedGender.value!,
        birthdate: selectedBirthdate.value!.toIso8601String(),
        dietaryChoices: selectedDietaryChoices.value,
        allergies: allergiesController.text,
      );

      context.read<DatabaseBloc>().add(AddDataEvent(data: data));
    }
  }

  @override
  void dispose() {
    selectedBirthdate.dispose();
    selectedGender.dispose();
    selectedDietaryChoices.dispose();
    selectedRace.dispose();
    allergiesController.dispose();
    birthdateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);

    return Scaffold(
      appBar: AppBar(
          title: Text(
        'Onboarding',
        style: Theme.of(context).textTheme.titleLarge,
      )),
      body: BlocConsumer<DatabaseBloc, DatabaseState>(
        buildWhen: (previous, current) => previous != current,
        listenWhen: (previous, current) => previous != current,
        listener: (context, state) {
          if (state is DatabaseErrorState &&
              state.errorSource == DatabaseEnum.add) {
            buildSnackbar(context, state.errorMessage);
          }
          if (state is DatabaseSuccessState &&
              state.successSource == DatabaseEnum.add) {
            Navigator.of(context)
                .pushNamedAndRemoveUntil(Profile.routeName, (route) => false);
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RaceDropdown(selectedRace),
                    const SizedBox(height: 16.0),
                    GenderDropdown(selectedGender),
                    const SizedBox(height: 16.0),
                    BirthdateField(selectedBirthdate, birthdateController),
                    const SizedBox(height: 16.0),
                    DietaryCheckboxes(selectedDietaryChoices),
                    const SizedBox(height: 16.0),
                    AllergiesField(allergiesController),
                    const SizedBox(height: 24.0),
                    Center(
                      child: state is DatabaseLoadingState &&
                              state.loadingSource == DatabaseEnum.add
                          ? buildLoadingButton(
                              screenSize.height * 1,
                              screenSize.height * 0.0747,
                            )
                          : ElevatedButton(
                              onPressed: _submitForm,
                              child: const Text('Submit'),
                            ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
