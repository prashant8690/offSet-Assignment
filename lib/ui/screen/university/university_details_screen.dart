import 'package:flutter/material.dart';
import 'package:offsetfarm_assignment/core/const/app_colors.dart';
import 'package:offsetfarm_assignment/core/const/app_settings.dart';
import 'package:offsetfarm_assignment/model/university_details_model.dart';
import 'package:offsetfarm_assignment/ui/screen/university/university_vm.dart';

import 'package:offsetfarm_assignment/ui/widget/custtom_text.dart';
import 'package:provider/provider.dart';

class UniversityDetailsScreen extends StatefulWidget {
  final UniversityDetailsModel universityDetailsModel;
  static const String routeName = "/universityDetailsScreen";
  const UniversityDetailsScreen(
      {Key? key, required this.universityDetailsModel})
      : super(key: key);

  @override
  State<UniversityDetailsScreen> createState() =>
      _UniversityDetailsScreenState();
}

class _UniversityDetailsScreenState extends State<UniversityDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.primaryPurpleColour,
          title: const Text("University details"),
        ),
        body: Consumer<UniversityVm>(
          builder: (context, value, child) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: dataColumn(),
            );
          },
        ));
  }

  Column dataColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 20,
        ),
        const CusttomText(text: "University Name:-"),
        const Divider(
          thickness: 1,
          color: Colors.black,
        ),
        Text(
          widget.universityDetailsModel.name,
          style: const TextStyle(
            fontSize: 17,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const CusttomText(text: "State Name:-"),
        const Divider(
          thickness: 1,
          color: Colors.black,
        ),
        Text(
          widget.universityDetailsModel.stateProvince,
          style: const TextStyle(
            fontSize: 17,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const CusttomText(text: "Country Name:-"),
        const Divider(
          thickness: 1,
          color: Colors.black,
        ),
        Text(
          widget.universityDetailsModel.country,
          style: const TextStyle(
            fontSize: 17,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const CusttomText(text: "Alpha Code:-"),
        const Divider(
          thickness: 1,
          color: Colors.black,
        ),
        Text(
          widget.universityDetailsModel.alphaTwoCode,
          style: const TextStyle(
            fontSize: 17,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const CusttomText(text: "Web Pages:-"),
        const Divider(
          thickness: 1,
          color: Colors.black,
        ),
        Text(
          widget.universityDetailsModel.webPages.toString(),
          style: const TextStyle(
            fontSize: 17,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const CusttomText(text: "Domains:-"),
        const Divider(
          thickness: 1,
          color: Colors.black,
        ),
        Text(
          widget.universityDetailsModel.domains.toString(),
          style: const TextStyle(
            fontSize: 17,
          ),
        ),
      ],
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
                    "University Details",
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
}
