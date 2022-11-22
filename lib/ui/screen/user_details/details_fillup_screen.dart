// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:image_cropper/image_cropper.dart';

import 'package:image_picker/image_picker.dart';
import 'package:offsetfarm_assignment/core/const/app_colors.dart';
import 'package:offsetfarm_assignment/core/const/app_icon.dart';
import 'package:offsetfarm_assignment/core/const/app_settings.dart';
import 'package:offsetfarm_assignment/core/utils/app_function.dart';
import 'package:offsetfarm_assignment/core/utils/shared_prefrences.dart';
import 'package:offsetfarm_assignment/model/user_model.dart';
import 'package:offsetfarm_assignment/ui/details_fill_vm.dart';
import 'package:offsetfarm_assignment/ui/screen/dashboard/dashboard_screen.dart';
import 'package:offsetfarm_assignment/ui/widget/custom_textfield.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class DetailsFillUPScreen extends StatefulWidget {
  static const String routeName = '/detailsFillUPScreen';
  const DetailsFillUPScreen({Key? key}) : super(key: key);

  @override
  State<DetailsFillUPScreen> createState() => _DetailsFillUPScreenState();
}

class _DetailsFillUPScreenState extends State<DetailsFillUPScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    nameController.text = FirebaseAuth.instance.currentUser!.displayName!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          disposeKeyboard();
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: appBar(),
          body: Consumer<DetailsFillVm>(
            builder: (context, value, child) {
              return Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 40,
                      ),
                      GestureDetector(
                        onTap: () {
                          openBottomSheet();
                        },
                        child: Center(
                          child: Column(
                            children: [
                              Container(
                                height: 150,
                                width: 150,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(100),
                                  ),
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 1,
                                  ),
                                  image: value.imagePath != null
                                      ? DecorationImage(
                                          image: FileImage(value.imagePath!),
                                          fit: BoxFit.cover)
                                      : const DecorationImage(
                                          image: AssetImage(
                                            AppAssets.avtarDummy,
                                          ),
                                        ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text(
                                "Profile Picture",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const Text(
                        "User Name",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      CustomTexfield(
                          textEditingController: nameController,
                          validator: (val) =>
                              val!.trim().isEmpty ? "Field required" : null),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Your Age",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      CustomTexfield(
                          hintText: "Enter Your Age",
                          maxLength: 2,
                          validator: (val) =>
                              val!.trim().isEmpty ? "Field required " : null,
                          textEditingController: ageController,
                          textInputType: TextInputType.phone),
                      const SizedBox(
                        height: 60,
                      ),
                      GestureDetector(
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            if (value.imagePath != null) {
                              formKey.currentState!.save();
                              UserModel userModel = UserModel(
                                  name: nameController.text.trim(),
                                  age: int.parse(ageController.text),
                                  profilePicture: value.imagePath!.path);
                              GetIt.I.get<AppPrefs>().setUser(userModel);
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  DashBoardScreen.routeName, (route) => false);
                            } else {
                              flutterToast("Please Upload Profile Picture");
                            }
                          }
                        },
                        child: Container(
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: AppColor.defaultPurpleButton),
                          child: const Center(
                            child: Text(
                              "Continue to Dashboard",
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
          ),
        ));
  }

  PreferredSize appBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(60),
      child: Container(
        color: AppColor.primaryPurpleColour,
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppSettings.kDefaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              SizedBox(
                height: 40,
              ),
              Text(
                "User Details",
                style: TextStyle(color: Colors.white, fontSize: 20),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future browseImage(ImageSource imageSource) async {
    ImagePicker imagePicker = ImagePicker();
    try {
      var pickedFile =
          await imagePicker.pickImage(source: imageSource, imageQuality: 50);
      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: pickedFile!.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: AppColor.primaryPurpleColour,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
        ],
      );

      Provider.of<DetailsFillVm>(context, listen: false).imagePath =
          File(croppedFile!.path);
    } on Exception catch (e) {
      return Future.error(e);
    }
  }

  Future<void> openBottomSheet() async {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Photo Library'),
              tileColor: Colors.white,
              onTap: () async {
                await browseImage(ImageSource.gallery);
                Navigator.pop(context);
              },
            ),
            const Divider(
              height: 0.5,
            ),
            ListTile(
              leading: const Icon(Icons.photo_camera),
              title: const Text('Camera'),
              tileColor: Colors.white,
              onTap: () async {
                final cameraPermissionStatus = await Permission.camera.status;
                if (cameraPermissionStatus.isDenied) {
                  Permission.camera.request().then((value) async {
                    if (value.isPermanentlyDenied) {
                      await openAppSettings();
                    } else if (value.isDenied) {
                      Permission.camera.request();
                    } else if (value.isGranted) {
                      await browseImage(ImageSource.camera);
                    }
                  });
                } else if (cameraPermissionStatus.isRestricted) {
                  await openAppSettings();
                } else if (cameraPermissionStatus.isGranted) {
                  await browseImage(ImageSource.camera);
                }
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
