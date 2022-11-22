import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:offsetfarm_assignment/core/data/network/api_client.dart';
import 'package:offsetfarm_assignment/core/data/network/dio/dio_api_client.dart';
import 'package:offsetfarm_assignment/core/data/repository/user_repo.dart';
import 'package:offsetfarm_assignment/core/data/repository/user_repo_impl.dart';
import 'package:offsetfarm_assignment/core/utils/shared_prefrences.dart';
import 'package:offsetfarm_assignment/route/route_generator.dart';

import 'core/utils/global.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  GetIt.I.registerSingletonAsync(() => AppPrefs.getInstance());
  GetIt.I.registerSingletonAsync<ApiClient>(() => DioApiClient.getInstance());
  GetIt.I.registerSingletonWithDependencies<UserRepo>(() => UserRepoImpl(),
      dependsOn: [ApiClient]);
  await GetIt.I.allReady();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteGenerator.generateRoute,
      initialRoute: getInitialRoute,
    );
  }
}
