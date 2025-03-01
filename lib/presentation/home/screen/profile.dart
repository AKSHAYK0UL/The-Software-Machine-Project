import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:tsm/bloc/auth_bloc/bloc/auth_bloc.dart';
import 'package:tsm/bloc/database_bloc/bloc/database_bloc.dart';
import 'package:tsm/core/enums/database_enum.dart';
import 'package:tsm/presentation/auth/screen/signin.dart';
import 'package:tsm/presentation/home/widget/userdatatitle.dart';

class Profile extends StatefulWidget {
  static const routeName = "/profile";
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final currentUser = FirebaseAuth.instance.currentUser!;

  @override
  void initState() {
    super.initState();
    context.read<DatabaseBloc>().add(GetDataEvent());
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) => AlertDialog(
                  backgroundColor: Colors.white,
                  title: Text(
                    "Are You Sure?",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  content: Text(
                    "Are you sure you want to SignOut?",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        "No",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        context.read<AuthBloc>().add(SignOutEvent());
                        Navigator.of(context).pop();
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            Signin.routeName, (route) => false);
                      },
                      child: Text(
                        "Yes",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    )
                  ],
                ),
              );
            },
            icon: Icon(
              Icons.logout,
              color: Colors.red,
              size: screenSize.height * 0.0329,
            ),
          ),
        ],
      ),
      body: BlocBuilder<DatabaseBloc, DatabaseState>(
        buildWhen: (previous, current) => previous != current,
        builder: (context, state) {
          if (state is DatabaseLoadingState &&
              state.loadingSource == DatabaseEnum.get) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is DatabaseErrorState &&
              state.errorSource == DatabaseEnum.get) {
            return Text(state.errorMessage);
          }
          if (state is ProfileDataState &&
              state.dataSource == DatabaseEnum.get) {
            final profileData = state.data;
            return ListView(
              children: [
                SizedBox(
                  height: screenSize.height * 0.150,
                  width: screenSize.height * 0.070,
                  child: ClipRRect(
                    borderRadius:
                        BorderRadius.circular(screenSize.height * 0.166),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: screenSize.height * 0.125,
                      child: Lottie.asset(
                        "assets/userinfo.json",
                        repeat: false,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: screenSize.height * 0.0110),
                  child: Card(
                    elevation: screenSize.height * 0.00200,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(screenSize.height * 0.0131),
                    ),
                    margin: EdgeInsets.only(
                      bottom: screenSize.height * 0.0110,
                    ),
                    color: Colors.grey.shade300,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        buildUserInfo(
                          context: context,
                          title: "Name",
                          data: currentUser.displayName!,
                          screenSize: screenSize,
                        ),
                        buildUserInfo(
                          context: context,
                          title: "Email",
                          data: currentUser.email!,
                          screenSize: screenSize,
                        ),
                        buildUserInfo(
                          context: context,
                          title: "Race",
                          data: profileData.race,
                          screenSize: screenSize,
                        ),
                        buildUserInfo(
                          context: context,
                          title: "Gender",
                          data: profileData.gender,
                          screenSize: screenSize,
                        ),
                        buildUserInfo(
                          context: context,
                          title: "Birthdate",
                          data: profileData.birthdate,
                          screenSize: screenSize,
                        ),
                        buildUserInfo(
                          context: context,
                          title: "Dietary Choices",
                          data: profileData.dietaryChoices.join(", "),
                          screenSize: screenSize,
                        ),
                        buildUserInfo(
                          context: context,
                          title: "Allergies",
                          data: profileData.allergies ?? "",
                          screenSize: screenSize,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
