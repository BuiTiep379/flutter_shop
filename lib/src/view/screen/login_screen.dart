// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_shop_shoes/service/product_service.dart';
import 'package:flutter_shop_shoes/src/const/app_colors.dart';
import 'package:flutter_shop_shoes/src/const/app_font.dart';
import 'package:flutter_shop_shoes/src/data/service/user_service.dart';
import 'package:flutter_shop_shoes/src/router/router_path.dart';
import 'package:flutter_shop_shoes/src/view/screen/component/addaddress/text_field_address.dart';
import 'package:flutter_shop_shoes/src/viewmodel/auth_viemodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';

import '../../viewmodel/login_viewmodel.dart';
import '../../viewmodel/user_viewmodel.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passController = TextEditingController();
  bool isShowPass = false;

  @override
  Widget build(BuildContext context) {
    var userData = Provider.of<UserViewModel>(context, listen: true);
    var loginData = Provider.of<LoginViewModel>(context, listen: true);

    final authViewModel = Provider.of<AuthViewModel>(context, listen: true);
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
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
                  "Login",
                  style: AppFont.bold.copyWith(
                    color: Colors.black,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                // TextFieldAddress(vi
                //     textEditingController: emailController, lableText: "Email"),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(.2),
                          blurRadius: 1,
                          spreadRadius: 1,
                          offset: Offset(1, 1),
                        ),
                      ]),
                  child: TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: "Email",
                      alignLabelWithHint: true, // center labastyle
                      labelStyle: AppFont.regular.copyWith(
                        fontSize: 13,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),

                SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(.2),
                          blurRadius: 1,
                          spreadRadius: 1,
                          offset: Offset(1, 1),
                        ),
                      ]),
                  child: TextFormField(
                    controller: passController,
                    obscureText: isShowPass,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: "Password",
                      suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              isShowPass = !isShowPass;
                            });
                          },
                          child: Icon(
                            isShowPass
                                ? Icons.visibility
                                : Icons.visibility_off,
                            size: 16,
                          )),
                      alignLabelWithHint: true,
                      // center labastyle
                      labelStyle: AppFont.regular.copyWith(
                        fontSize: 13,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                GestureDetector(
                  onTap: () => Navigator.pushNamed(context, ForgotPassScreens),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      "Forgot yours password?",
                      style: AppFont.medium.copyWith(
                        fontSize: 13,
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Checkbox(
                      activeColor: AppColors.primaryColorRed,
                      value: true,
                      onChanged: (value) {},
                    ),
                    Text(
                      "Remember me?",
                      style: AppFont.medium.copyWith(
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 25,
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
                      // authViewModel
                      //     .login()
                      //     .then((value) => Navigator.pop(context));

                      // final Stream<QuerySnapshot> getUser =
                      //     UserService.readUser(emailController, context);

                      // SizedBox(child: ,)

                      // print(getUser);

                      bool getUser = await UserService.userExists(
                          emailController.text.toString(),
                          passController.text.toString()) as bool;
                      print(getUser);

                      if (getUser) {
                        final List<QueryDocumentSnapshot> userNotes =
                            await UserService().getUserUsername(
                                emailController.text.toString());

                        final Map<String, dynamic> e =
                            userNotes[0].data() as Map<String, dynamic>;

                        userData.addItems(
                            e["id"],
                            e["name"],
                            e["username"],
                            e["password"],
                            e["phone"],
                            e["line"],
                            e["district"],
                            e["ward"],
                            userNotes[0].id);

                        loginData.addItems(emailController.text.toString());
                        if (emailController.text.toString() ==
                            "admin@gmail.com") {
                          Get.toNamed("/dashboard-admin");
                        } else {
                          Get.toNamed("/");
                        }
                      } else {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                content: Text("Login không thành công !"),
                              );
                            });
                      }

                      // SizedBox(
                      //   height: 10,
                      //   child: StreamBuilder(
                      //     stream: getUser,
                      //     builder: (BuildContext context,
                      //         AsyncSnapshot<QuerySnapshot> snapshot) {
                      //       if (snapshot.hasData) {
                      //         return GridView.count(
                      //           scrollDirection: Axis.horizontal,
                      //           crossAxisCount: 1,
                      //           // padding: EdgeInsets.all(1.0),
                      //           childAspectRatio: 2 / 1,
                      //           children: snapshot.data!.docs.map((e) {
                      //             // print(e["id"]);
                      //             // print(e["name"]);
                      //             // print(e["username"]);
                      //             // print(e["password"]);
                      //             // print(e["phone"]);
                      //             // print(e["line"]);
                      //             // print(e["district"]);
                      //             // print(e["ward"]);
                      //             userData.addItems(
                      //                 e["id"],
                      //                 e["name"],
                      //                 e["username"],
                      //                 e["password"],
                      //                 e["phone"],
                      //                 e["line"],
                      //                 e["district"],
                      //                 e["ward"],
                      //                 snapshot.data!.docs[0].id);
                      //             Get.toNamed("/");
                      //             return Container(
                      //               child: Text("${userData.itemCount}"),
                      //             );
                      //           }).toList(),
                      //         );
                      //       }

                      //       return SizedBox(
                      //         height: 100,
                      //         child: Container(
                      //           child: Text(""),
                      //         ),
                      //       );
                      //     },
                      //   ),
                      // );
                    },
                    child: Text(
                      "Login".toUpperCase(),
                      style: AppFont.medium
                          .copyWith(fontSize: 15, color: Colors.white),
                    ),
                  ),
                ),
                Spacer(),
                InkWell(
                  onTap: () {
                    Get.toNamed("/register");
                  },
                  child: Center(
                      child: RichText(
                    text: TextSpan(
                        text: "Don't have a account? ",
                        style: AppFont.medium.copyWith(fontSize: 13),
                        children: [
                          TextSpan(
                            text: "Register",
                            style: AppFont.bold.copyWith(
                                fontSize: 13, color: AppColors.primaryColorRed),
                          )
                        ]),
                  )),
                ),
                SizedBox(
                  height: 10,
                ),

                Center(
                  child: Text(
                    'Or',
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
                          'assets/images/ic_google.svg',
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
                          'assets/images/ic_fb.svg',
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
    );
  }
}
