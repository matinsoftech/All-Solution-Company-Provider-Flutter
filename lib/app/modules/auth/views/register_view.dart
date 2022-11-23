import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:place_picker/place_picker.dart';

import '../../../../common/helper.dart';
import '../../../../common/ui.dart';
import '../../../models/setting_model.dart';
import '../../../routes/app_routes.dart';
import '../../../services/settings_service.dart';
import '../../global_widgets/block_button_widget.dart';
import '../../global_widgets/circular_loading_widget.dart';
import '../../global_widgets/text_field_widget.dart';
import '../../root/controllers/root_controller.dart';
import '../controllers/auth_controller.dart';

class RegisterView extends GetView<AuthController> {
  final Setting _settings = Get.find<SettingsService>().setting.value;

  @override
  Widget build(BuildContext context) {
    controller.registerFormKey = new GlobalKey<FormState>();
    return WillPopScope(
      onWillPop: Helper().onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Register".tr,
            style: Get.textTheme.headline6
                .merge(TextStyle(color: context.theme.primaryColor)),
          ),
          centerTitle: true,
          backgroundColor: Get.theme.accentColor,
          automaticallyImplyLeading: false,
          elevation: 0,
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back_ios, color: Get.theme.primaryColor),
            onPressed: () => {Get.find<RootController>().changePageOutRoot(0)},
          ),
        ),
        body: Form(
          key: controller.registerFormKey,
          child: ListView(
            primary: true,
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: [
                  Container(
                    height: 160,
                    width: Get.width,
                    decoration: BoxDecoration(
                      color: Get.theme.accentColor,
                      borderRadius:
                          BorderRadius.vertical(bottom: Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(
                            color: Get.theme.focusColor.withOpacity(0.2),
                            blurRadius: 10,
                            offset: Offset(0, 5)),
                      ],
                    ),
                    margin: EdgeInsets.only(bottom: 50),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Text(
                            _settings.appName,
                            style: Get.textTheme.headline6.merge(TextStyle(
                                color: Get.theme.primaryColor, fontSize: 24)),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "Welcome to the best service provider system!".tr,
                            style: Get.textTheme.caption.merge(
                                TextStyle(color: Get.theme.primaryColor)),
                            textAlign: TextAlign.center,
                          ),
                          // Text("Fill the following credentials to login your account", style: Get.textTheme.caption.merge(TextStyle(color: Get.theme.primaryColor))),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    decoration: Ui.getBoxDecoration(
                      radius: 14,
                      border:
                          Border.all(width: 5, color: Get.theme.primaryColor),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      child: Image.asset(
                        'assets/icon/icon.png',
                        fit: BoxFit.cover,
                        width: 100,
                        height: 100,
                      ),
                    ),
                  ),
                ],
              ),
              Obx(() {
                if (controller.loading.isTrue) {
                  return CircularLoadingWidget(height: 300);
                } else {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Get.theme.primaryColor,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color: Get.theme.focusColor.withOpacity(0.1),
                                  blurRadius: 10,
                                  offset: Offset(0, 5)),
                            ],
                            border: Border.all(
                                color: Get.theme.focusColor.withOpacity(0.05))),
                        margin: const EdgeInsets.all(20),
                        padding: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("Profile Image"),
                            Obx(
                                  () => Align(
                                alignment: Alignment.topLeft,
                                child: Container(
                                  height: 80,
                                  width: 80,
                                  padding: EdgeInsets.all(5),
                                  child: controller.currentUser.value
                                      .profileImg !=
                                      null
                                      ? Image.memory(base64Decode(controller
                                      .currentUser.value.profileImg
                                      .replaceAll(
                                      "data:image/jpeg;base64,", "")))
                                      : IconButton(
                                    onPressed: () => controller
                                        .pickProfileImage(),
                                    icon: Icon(Icons.add),
                                  ),
                                ),
                              ),
                            ),

                          ],
                        ),
                      ),

                      TextFieldWidget(
                        labelText: "Full Name".tr,
                        hintText: "John Doe".tr,
                        onSaved: (input) =>
                            controller.currentUser.value.name = input,
                        validator: (input) => input.length < 3
                            ? "Should be more than 3 characters".tr
                            : null,
                        iconData: Icons.person_outline,
                        isFirst: true,
                        isLast: false,
                      ),
                      TextFieldWidget(
                        labelText: "Email Address".tr,
                        hintText: "johndoe@gmail.com".tr,
                        onSaved: (input) =>
                            controller.currentUser.value.email = input,
                        validator: (input) => !input.contains('@')
                            ? "Should be a valid email".tr
                            : null,
                        iconData: Icons.alternate_email,
                        isFirst: false,
                        isLast: false,
                      ),
                      TextFieldWidget(
                        labelText: "Phone Number".tr,
                        hintText: " 1234567897".tr,
                        onSaved: (input) {
                          input = "+977" + input;
                          return controller.currentUser.value.phoneNumber =
                              input;
                        },
                        validator: (input) {
                          return null;
                        },
                        iconData: Icons.phone_android_outlined,
                        isLast: false,
                        isFirst: false,
                      ),
                      TextFieldWidget(
                        labelText: "Instagram Url".tr,
                        hintText: " https://instagram......".tr,
                        onSaved: (input) {
                          return controller.currentUser.value.instagramUrl =
                              input;
                        },
                        validator: (input) {
                          return null;
                        },
                        iconData: Icons.link,
                        isLast: false,
                        isFirst: false,
                      ),
                      TextFieldWidget(
                        labelText: "Facebook Url".tr,
                        hintText: " https://facebook.com/".tr,
                        onSaved: (input) {
                          return controller.currentUser.value.facebookUrl =
                              input;
                        },
                        validator: (input) {
                          return null;
                        },
                        iconData: Icons.link,
                        isLast: false,
                        isFirst: false,
                      ),
                      TextFieldWidget(
                        labelText: "Youtube Url".tr,
                        hintText: " https://youtube.com/".tr,
                        onSaved: (input) {
                          return controller.currentUser.value.youtubeUrl =
                              input;
                        },
                        validator: (input) {
                          return null;
                        },
                        iconData: Icons.link,
                        isLast: false,
                        isFirst: false,
                      ),

                      TextFieldWidget(
                        labelText: "Address ".tr,
                        controller: controller.addressController,
                        hintText: "Kathmandu Nepal".tr,
                        onSaved: (input) {
                          return controller.currentUser.value.address = input;
                        },
                        validator: (input) {
                          return null;
                        },
                        iconData: Icons.phone_android_outlined,
                        isLast: false,
                        isFirst: false,
                      ),

                      Container(
                        padding: EdgeInsets.only(
                            top: 4, bottom: 4, left: 20, right: 20),
                        margin: EdgeInsets.only(
                            left: 20, right: 20, top: 20, bottom: 20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.grey)),
                        child: MaterialButton(
                            child: Text("Pick Address"),
                            onPressed: () async {
                              LocationResult result = await Navigator.of(
                                      context)
                                  .push(MaterialPageRoute(
                                      builder: (context) => PlacePicker(
                                          "AIzaSyAdfyIlj7h9S8qPnnGpYXeoBlxoePvrUVI")));

                              // Handle the result in your way
                              controller.addressController.text =
                                  result.formattedAddress;
                              controller.currentUser.value.latitude =
                                  result.latLng.latitude.toString();
                              controller.currentUser.value.longitude =
                                  result.latLng.longitude.toString();
                            }),
                      ),
                      TextFieldWidget(
                        labelText: "Your Description ".tr,
                        hintText: "Work ".tr,
                        onSaved: (input) {
                          return controller.currentUser.value.description =
                              input;
                        },
                        validator: (input) {
                          return null;
                        },
                        iconData: Icons.location_on_outlined,
                        isLast: false,
                        isFirst: false,
                      ),
                      // Container(
                      //   padding: EdgeInsets.only(
                      //       top: 20, bottom: 14, left: 20, right: 20),
                      //   margin: EdgeInsets.only(
                      //       left: 20, right: 20, top: 10, bottom: 10),
                      //   decoration: BoxDecoration(
                      //       color: Get.theme.primaryColor,
                      //       borderRadius: BorderRadius.all(Radius.circular(10)),
                      //       boxShadow: [
                      //         BoxShadow(
                      //             color: Get.theme.focusColor.withOpacity(0.1),
                      //             blurRadius: 10,
                      //             offset: Offset(0, 5)),
                      //       ],
                      //       border: Border.all(
                      //           color: Get.theme.focusColor.withOpacity(0.05))),
                      //   child: Column(
                      //     crossAxisAlignment: CrossAxisAlignment.stretch,
                      //     children: [
                      //       Text(
                      //         "Image",
                      //         style: Get.textTheme.bodyText1,
                      //         textAlign: TextAlign.start,
                      //       ),
                      //       Obx(() {
                      //         return GestureDetector(
                      //           onTap:()=>controller.pickImage(),
                      //           child: controller.currentUser.value.avatar !=
                      //                   null
                      //               ? Image.file(
                      //                   File(controller
                      //                       .currentUser.value.avatar.path),
                      //                   width: 100,
                      //                   height: 100)
                      //               : Icon(Icons.add_photo_alternate_outlined,
                      //                   size: 42,
                      //                   color: Get.theme.focusColor
                      //                       .withOpacity(0.4)),
                      //         );
                      //       }),
                      //     ],
                      //   ),
                      // ),
                      Obx(() {
                        return TextFieldWidget(
                          labelText: "Password".tr,
                          hintText: "••••••••••••".tr,
                          onSaved: (input) =>
                              controller.currentUser.value.password = input,
                          validator: (input) => input.length < 3
                              ? "Should be more than 3 characters".tr
                              : null,
                          obscureText: controller.hidePassword.value,
                          iconData: Icons.lock_outline,
                          keyboardType: TextInputType.visiblePassword,
                          isLast: true,
                          isFirst: false,
                          suffixIcon: IconButton(
                            onPressed: () {
                              controller.hidePassword.value =
                                  !controller.hidePassword.value;
                            },
                            color: Theme.of(context).focusColor,
                            icon: Icon(controller.hidePassword.value
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined),
                          ),
                        );
                      }),
                      Container(
                        decoration: BoxDecoration(
                            color: Get.theme.primaryColor,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color: Get.theme.focusColor.withOpacity(0.1),
                                  blurRadius: 10,
                                  offset: Offset(0, 5)),
                            ],
                            border: Border.all(
                                color: Get.theme.focusColor.withOpacity(0.05))),
                        margin: const EdgeInsets.all(20),
                        padding: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("Citizenship Front Image"),
                            Obx(
                              () => Align(
                                alignment: Alignment.topLeft,
                                child: Container(
                                  height: 80,
                                  width: 80,
                                  padding: EdgeInsets.all(5),
                                  child: controller.currentUser.value
                                              .citizenshipFront !=
                                          null
                                      ? Image.memory(base64Decode(controller
                                          .currentUser.value.citizenshipFront
                                          .replaceAll(
                                              "data:image/jpeg;base64,", "")))
                                      : IconButton(
                                          onPressed: () => controller
                                              .pickCitizenFrontImage(),
                                          icon: Icon(Icons.add),
                                        ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text("Citizenship Back Image"),
                            Obx(
                              () => Align(
                                alignment: Alignment.topLeft,
                                child: Container(
                                  height: 80,
                                  width: 80,
                                  padding: EdgeInsets.all(5),
                                  child: controller.currentUser.value
                                              .citizenshipBack !=
                                          null
                                      ? Image.memory(base64Decode(controller
                                          .currentUser.value.citizenshipBack
                                          .replaceAll(
                                              "data:image/jpeg;base64,", "")))
                                      : IconButton(
                                          onPressed: () => controller
                                              .pickCitizenBackImage(),
                                          icon: Icon(Icons.add),
                                        ),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  );
                }
              })
            ],
          ),
        ),
        bottomNavigationBar: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              direction: Axis.vertical,
              children: [
                SizedBox(
                  width: Get.width,
                  child: BlockButtonWidget(
                    onPressed: () {
                      controller.register();
                      //Get.offAllNamed(Routes.PHONE_VERIFICATION);
                    },
                    color: Get.theme.accentColor,
                    text: Text(
                      "Register".tr,
                      style: Get.textTheme.headline6
                          .merge(TextStyle(color: Get.theme.primaryColor)),
                    ),
                  ).paddingOnly(top: 15, bottom: 5, right: 20, left: 20),
                ),
                TextButton(
                  onPressed: () {
                    Get.toNamed(Routes.LOGIN);
                  },
                  child: Text("You already have an account?".tr),
                ).paddingOnly(bottom: 10),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
