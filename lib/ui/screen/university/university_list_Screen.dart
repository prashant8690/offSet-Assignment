import 'package:flutter/material.dart';
import 'package:offsetfarm_assignment/core/const/app_colors.dart';
import 'package:offsetfarm_assignment/core/const/app_icon.dart';
import 'package:offsetfarm_assignment/core/const/app_settings.dart';
import 'package:offsetfarm_assignment/ui/screen/university/university_vm.dart';
import 'package:provider/provider.dart';

import 'university_details_screen.dart';

class UniversityListScreen extends StatefulWidget {
  static const String routeName = "/universityListScreen";
  const UniversityListScreen({Key? key}) : super(key: key);

  @override
  State<UniversityListScreen> createState() => _UniversityListScreenState();
}

class _UniversityListScreenState extends State<UniversityListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primaryPurpleColour,
        title: const Text("University List"),
      ),
      body: Consumer<UniversityVm>(
        builder: (context, value, child) {
          if (value.isLoading) {
            return const Center(
              child: CircularProgressIndicator(
                  color: AppColor.primaryPurpleColour),
            );
          }
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: value.universityList.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        listTile(value, index),
                        const Divider(
                          thickness: 1,
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  PreferredSize appBar(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(60),
      child: Container(
        color: AppColor.primaryPurpleColour,
        child: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: AppSettings.kDefaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_new_outlined,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    "University List",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  ListTile listTile(UniversityVm value, int index) {
    return ListTile(
      leading: Image.asset(AppAssets.university, height: 35, fit: BoxFit.cover),
      trailing: IconButton(
        icon: const Icon(
          Icons.keyboard_arrow_right,
          size: 28,
        ),
        onPressed: () {
          Navigator.pushNamed(context, UniversityDetailsScreen.routeName,
              arguments: value.universityList[index]);
        },
      ),
      title: Text(
        value.universityList[index].name,
        style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        value.universityList[index].stateProvince,
        style: const TextStyle(
          fontSize: 15,
        ),
      ),
    );
  }
}
