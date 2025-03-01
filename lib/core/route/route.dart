import 'package:flutter/cupertino.dart';
import 'package:tsm/presentation/auth/screen/forgotpassword.dart';
import 'package:tsm/presentation/auth/screen/signin.dart';
import 'package:tsm/presentation/auth/screen/signup.dart';
import 'package:tsm/presentation/auth/screen/verification.dart';
import 'package:tsm/presentation/boarding/screen/onboarding.dart';
import 'package:tsm/presentation/home/screen/profile.dart';

Map<String, WidgetBuilder> routes = {
  Signup.routeName: (context) => const Signup(),
  Signin.routeName: (context) => const Signin(),
  ForgotPassword.routeName: (context) => const ForgotPassword(),
  Verification.routeName: (context) => const Verification(),
  Onboarding.routeName: (context) => const Onboarding(),
  Profile.routeName: (context) => const Profile(),
};
