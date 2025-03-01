import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tsm/bloc/auth_bloc/bloc/auth_bloc.dart';
import 'package:tsm/bloc/auth_state_bloc/bloc/auth_state_bloc.dart';
import 'package:tsm/bloc/database_bloc/bloc/database_bloc.dart';
import 'package:tsm/core/route/route.dart';
import 'package:tsm/core/theme/themedata.dart';
import 'package:tsm/secrets/firebase_options.dart';
import 'package:tsm/network/auth/auth_network.dart';
import 'package:tsm/network/database/database_network.dart';
import 'package:tsm/presentation/auth/screen/signin.dart';
import 'package:tsm/presentation/home/screen/profile.dart';
import 'package:tsm/repository/auth/auth_repo.dart';
import 'package:tsm/repository/database/database_repo.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final firebaseAuthInstance = FirebaseAuth.instance;
  final firebaseFireStore = FirebaseFirestore.instance;
  runApp(MyApp(
    firebaseAuthInstance: firebaseAuthInstance,
    firebaseFireStore: firebaseFireStore,
  ));
}

class MyApp extends StatelessWidget {
  final FirebaseAuth firebaseAuthInstance;
  final FirebaseFirestore firebaseFireStore;

  const MyApp(
      {super.key,
      required this.firebaseAuthInstance,
      required this.firebaseFireStore});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => AuthRepo(
            authNetwork: AuthNetwork(firebaseAuth: firebaseAuthInstance),
          ),
        ),
        RepositoryProvider(
          create: (context) => DatabaseRepo(
            databaseNetwork: DatabaseNetwork(
                firestoreInstance: firebaseFireStore,
                userId: firebaseAuthInstance.currentUser!.uid),
          ),
        )
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthBloc(context.read<AuthRepo>()),
          ),
          BlocProvider(
              create: (context) => AuthStateBloc(firebaseAuthInstance)),
          BlocProvider(
            create: (context) => DatabaseBloc(context.read<DatabaseRepo>()),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: theme(context),
          routes: routes,
          home: BlocSelector<AuthStateBloc, AuthStateState, bool>(
            selector: (state) {
              return state is LoggedInState;
            },
            builder: (context, isloggedIn) {
              if (isloggedIn) {
                return const Profile();
              } else {
                return const Signin();
              }
            },
          ),
        ),
      ),
    );
  }
}
