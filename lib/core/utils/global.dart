import 'package:firebase_auth/firebase_auth.dart';
import 'package:offsetfarm_assignment/ui/screen/dashboard/dashboard_screen.dart';
import 'package:offsetfarm_assignment/ui/screen/login/login_screen.dart';

String get getInitialRoute {
  if (FirebaseAuth.instance.currentUser != null) {
    return DashBoardScreen.routeName;
  } else {
    return LoginScreen.routeName;
  }
}
