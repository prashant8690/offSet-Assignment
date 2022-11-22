import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:offsetfarm_assignment/core/const/app_colors.dart';
import 'package:offsetfarm_assignment/core/const/app_icon.dart';
import 'package:offsetfarm_assignment/core/const/app_settings.dart';
import 'package:offsetfarm_assignment/core/utils/app_function.dart';
import 'package:offsetfarm_assignment/core/utils/shared_prefrences.dart';
import 'package:offsetfarm_assignment/ui/screen/dashboard/vm/dashboard_vm.dart';
import 'package:offsetfarm_assignment/ui/screen/login/login_screen.dart';
import 'package:offsetfarm_assignment/ui/screen/university/university_list_Screen.dart';
import 'package:provider/provider.dart';

class DashBoardScreen extends StatefulWidget {
  static const String routeName = '/dashBoardScreen';
  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: () {
      disposeKeyboard();
    }, child: Consumer<DashBoardVm>(
      builder: (context, value, child) {
        if (value.userModel == null) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        return Scaffold(
          appBar: appBar(value, context),
          body: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppSettings.kDefaultPadding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                        context, UniversityListScreen.routeName);
                  },
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: AppColor.defaultPurpleButton),
                    child: const Center(
                      child: Text(
                        "View List of University",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 19),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ));
  }

  PreferredSize appBar(DashBoardVm value, BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(80),
      child: Container(
        color: AppColor.primaryPurpleColour,
        child: Padding(
          padding: const EdgeInsets.only(left: AppSettings.kDefaultPadding),
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 32,
                    child: CircleAvatar(
                      radius: 30,
                      backgroundImage:
                          FileImage(File(value.userModel!.profilePicture)),
                      backgroundColor: AppColor.primaryPurpleColour,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        value.userModel!.name,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            const TextSpan(
                              text: "Age ",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                            TextSpan(
                                text: value.userModel!.age.toString(),
                                style: const TextStyle(fontSize: 16)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: const Text(
                            "Log Out",
                            style: TextStyle(
                              color: AppColor.primaryPurpleColour,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          content: const Text(
                            "Do you really want to logout?",
                            style: TextStyle(
                                color: AppColor.primaryPurpleColour,
                                fontSize: 15),
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                FirebaseAuth.instance.signOut();
                                GetIt.I.get<AppPrefs>().clear();
                                Navigator.pushReplacementNamed(
                                    context, LoginScreen.routeName);
                              },
                              child: const Text(
                                "Yes",
                                style: TextStyle(
                                    color: AppColor.primaryPurpleColour),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text(
                                "No",
                                style: TextStyle(
                                    color: AppColor.primaryPurpleColour),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    icon: Padding(
                      padding: const EdgeInsets.only(
                          top: AppSettings.kDefaultPadding - 10),
                      child: Image.asset(
                        color: Colors.white,
                        AppAssets.logOut,
                        height: 20,
                        width: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
