import 'package:flutter/material.dart';
import 'package:offsetfarm_assignment/model/university_details_model.dart';
import 'package:offsetfarm_assignment/ui/details_fill_vm.dart';
import 'package:offsetfarm_assignment/ui/screen/user_details/details_fillup_screen.dart';
import 'package:offsetfarm_assignment/ui/screen/dashboard/dashboard_screen.dart';
import 'package:offsetfarm_assignment/ui/screen/dashboard/vm/dashboard_vm.dart';
import 'package:offsetfarm_assignment/ui/screen/login/login_screen.dart';
import 'package:offsetfarm_assignment/ui/screen/login/vm/login_vm.dart';
import 'package:offsetfarm_assignment/ui/screen/university/university_details_screen.dart';
import 'package:offsetfarm_assignment/ui/screen/university/university_list_Screen.dart';
import 'package:offsetfarm_assignment/ui/screen/university/university_vm.dart';
import 'package:provider/provider.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case DetailsFillUPScreen.routeName:
        return MaterialPageRoute(
            builder: (_) => ChangeNotifierProvider(
                  create: (context) => DetailsFillVm(),
                  child: const DetailsFillUPScreen(),
                ));
      case LoginScreen.routeName:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => ChangeNotifierProvider<LoginVm>(
            create: (_) => LoginVm(),
            child: const LoginScreen(),
          ),
        );
      case DashBoardScreen.routeName:
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => ChangeNotifierProvider<DashBoardVm>(
                  create: (_) => DashBoardVm(),
                  child: const DashBoardScreen(),
                ));
      case UniversityListScreen.routeName:
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => ChangeNotifierProvider<UniversityVm>(
                  create: (_) => UniversityVm(),
                  child: const UniversityListScreen(),
                ));
      case UniversityDetailsScreen.routeName:
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => ChangeNotifierProvider<UniversityVm>(
                  create: (_) => UniversityVm(),
                  child: UniversityDetailsScreen(
                      universityDetailsModel:
                          settings.arguments as UniversityDetailsModel),
                ));
      default:
        debugPrint('Navigating to ${settings.name}');
        return errorRoute();
    }
  }

  static Route<dynamic> errorRoute() {
    return MaterialPageRoute(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Arggg!'),
          ),
          body: const Center(
            child: Text('Oh No! You should not be here! '),
          ),
        );
      },
    );
  }
}
