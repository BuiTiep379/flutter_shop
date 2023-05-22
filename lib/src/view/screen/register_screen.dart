import 'package:flutter_shop_shoes/src/const/app_colors.dart';
import 'package:flutter_shop_shoes/src/const/app_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../data/service/user_service.dart';
import 'component/addaddress/text_field_address.dart';

class RegisterScreen extends StatelessWidget {
  final nameController = TextEditingController();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();
  final lineController = TextEditingController();

  final districtController = TextEditingController();
  final wardController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Container(
              height: 1000,
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                      onPressed: () => Navigator.pop(context),
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.all(0.0),
                      icon: Icon(
                        Icons.arrow_back_ios_rounded,
                        color: Colors.black,
                        size: 20,
                      )),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Sign up",
                    style: AppFont.bold.copyWith(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  TextFieldAddress(
                      textEditingController: nameController, lableText: "Name"),
                  SizedBox(
                    height: 25,
                  ),
                  TextFieldAddress(
                      textEditingController: emailController,
                      lableText: "Email"),
                  SizedBox(
                    height: 25,
                  ),
                  TextFieldAddress(
                      textEditingController: passwordController,
                      lableText: "Password"),
                  SizedBox(
                    height: 25,
                  ),
                  TextFieldAddress(
                      textEditingController: phoneController,
                      lableText: "Phone"),
                  SizedBox(
                    height: 25,
                  ),
                  TextFieldAddress(
                      textEditingController: lineController, lableText: "Line"),
                  SizedBox(
                    height: 25,
                  ),
                  TextFieldAddress(
                      textEditingController: districtController,
                      lableText: "District"),
                  SizedBox(
                    height: 25,
                  ),
                  TextFieldAddress(
                      textEditingController: wardController, lableText: "Ward"),
                  SizedBox(
                    height: 25,
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      "Already have an account?",
                      style: AppFont.medium.copyWith(
                        fontSize: 13,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: AppColors.primaryColorRed,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40.0),
                        ),
                      ),
                      onPressed: () async {
                        var response = await UserService.addUser(
                          name: nameController.text,
                          username: emailController.text,
                          password: passwordController.text,
                          phone: phoneController.text,
                          line: lineController.text,
                          district: districtController.text,
                          ward: wardController.text,
                        );
                        if (response.code != 200) {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  content: Text(response.message.toString()),
                                );
                              });
                        } else {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  content: Text(response.message.toString()),
                                );
                              });

                          Get.toNamed("/login");
                        }
                      },
                      child: Text(
                        "sign up".toUpperCase(),
                        style: AppFont.medium
                            .copyWith(fontSize: 15, color: Colors.white),
                      ),
                    ),
                  ),
                  Spacer(),
                  Center(
                    child: Text(
                      'Or login with social account',
                      style: AppFont.medium.copyWith(
                        fontSize: 13,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 80),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: 80,
                          height: 65,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(.1),
                                  offset: Offset(1, 1),
                                  blurRadius: 1,
                                  spreadRadius: 2,
                                )
                              ]),
                          child: SvgPicture.asset(
                            'assets/image/ic_google.svg',
                            width: 10,
                            height: 10,
                            fit: BoxFit.scaleDown,
                          ),
                        ),
                        Container(
                          width: 80,
                          height: 65,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(.1),
                                  offset: Offset(1, 1),
                                  blurRadius: 1,
                                  spreadRadius: 2,
                                )
                              ]),
                          child: SvgPicture.asset(
                            'assets/image/ic_fb.svg',
                            width: 10,
                            height: 10,
                            fit: BoxFit.scaleDown,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
