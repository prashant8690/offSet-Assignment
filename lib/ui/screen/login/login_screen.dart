import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:offsetfarm_assignment/core/const/app_colors.dart';
import 'package:offsetfarm_assignment/core/const/app_icon.dart';
import 'package:offsetfarm_assignment/ui/screen/user_details/details_fillup_screen.dart';
import 'package:offsetfarm_assignment/ui/screen/login/vm/login_vm.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/loginScreen';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: Consumer<LoginVm>(
          builder: (BuildContext context, value, child) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 400,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/background.png'),
                            fit: BoxFit.fill)),
                    child: Stack(
                      children: [
                        Positioned(
                          child: Container(
                            margin: const EdgeInsets.only(top: 50),
                            child: const Center(
                              child: Text(
                                "Login",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                    color: Color.fromRGBO(143, 148, 251, .2),
                                    blurRadius: 20.0,
                                    offset: Offset(0, 10))
                              ]),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        GestureDetector(
                          onTap: () async {
                            User? user = await value.googleLogin();
                            if (user != null) {
                              Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  DetailsFillUPScreen.routeName,
                                  (route) => false);
                            }
                          },
                          child: socialButton(),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        ));
  }

  Container socialButton() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: AppColor.defaultPurpleButton),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Image(
            image: AssetImage(AppAssets.google),
            fit: BoxFit.cover,
            height: 40,
            width: 40,
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            "Google Login",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22),
          ),
        ],
      ),
    );
  }
}
