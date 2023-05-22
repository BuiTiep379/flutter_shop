import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_shop_shoes/src/const/app_font.dart';
import 'package:flutter_shop_shoes/src/data/service/user_service.dart';
import 'package:flutter_shop_shoes/src/router/router_path.dart';
import 'package:flutter_shop_shoes/src/view/screen/choice_address_screen.dart';
import 'package:flutter_shop_shoes/src/viewmodel/product_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';

import '../../viewmodel/user_viewmodel.dart';

class PersonalTab extends StatefulWidget {
  @override
  _PersonalTabState createState() => _PersonalTabState();
}

class _PersonalTabState extends State<PersonalTab> {
  @override
  Widget build(BuildContext context) {
    var userData = Provider.of<UserViewModel>(context);

    var productVM = Provider.of<ProductViewModel>(context, listen: false);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Container(
            child: Column(
              children: [
                userData.itemCount > 0
                    ? Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 70,
                                height: 70,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          'data:image/jpeg;base64,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'),
                                      fit: BoxFit.cover),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${userData.items.values.toList()[0].name}",
                                      style: AppFont.semiBold.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "${userData.items.values.toList()[0].username}",
                                      style: AppFont.medium.copyWith(
                                          fontWeight: FontWeight.w500,
                                          color: Colors.grey,
                                          fontSize: 14),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          InkWell(
                            onTap: () {
                              Get.toNamed("/list-order");
                            },
                            child: ListTile(
                              contentPadding: EdgeInsets.all(0.0),
                              title: Text(
                                "List Orders",
                                style: AppFont.semiBold.copyWith(
                                    fontWeight: FontWeight.bold, fontSize: 17),
                              ),
                              subtitle: Text(
                                "order for you",
                                style: AppFont.regular.copyWith(
                                    fontWeight: FontWeight.w100,
                                    fontSize: 13,
                                    color: Colors.grey),
                              ),
                              trailing: IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.arrow_forward_ios,
                                  size: 18,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Get.toNamed("/list-notifications");
                            },
                            child: ListTile(
                              contentPadding: EdgeInsets.all(0.0),
                              title: Text(
                                "Notifications",
                                style: AppFont.semiBold.copyWith(
                                    fontWeight: FontWeight.bold, fontSize: 17),
                              ),
                              subtitle: Text(
                                "note for you",
                                style: AppFont.regular.copyWith(
                                    fontWeight: FontWeight.w100,
                                    fontSize: 13,
                                    color: Colors.grey),
                              ),
                              trailing: IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.arrow_forward_ios,
                                  size: 18,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Get.toNamed("/edit-person");
                            },
                            child: ListTile(
                              contentPadding: EdgeInsets.all(0.0),
                              title: Text(
                                "Edit Profile",
                                style: AppFont.semiBold.copyWith(
                                    fontWeight: FontWeight.bold, fontSize: 17),
                              ),
                              subtitle: Text(
                                "",
                                style: AppFont.regular.copyWith(
                                    fontWeight: FontWeight.w100,
                                    fontSize: 13,
                                    color: Colors.grey),
                              ),
                              trailing: IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.arrow_forward_ios,
                                  size: 18,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                          ListTile(
                            contentPadding: EdgeInsets.all(0.0),
                            title: Text(
                              "Logout",
                              style: AppFont.semiBold.copyWith(
                                  fontWeight: FontWeight.bold, fontSize: 17),
                            ),
                            subtitle: Text(
                              '',
                              style: AppFont.regular.copyWith(
                                  fontWeight: FontWeight.w100,
                                  fontSize: 13,
                                  color: Colors.grey),
                            ),
                            trailing: IconButton(
                              onPressed: () {
                                userData.clear();
                                Get.toNamed("/");
                              },
                              icon: Icon(
                                Icons.arrow_forward_ios,
                                size: 18,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      )
                    : Container(
                        child: Column(
                          children: [
                            Container(
                              width: double.infinity,
                              child: Text("Vui lòng đăng nhập tài khoản !"),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            ListTile(
                              contentPadding: EdgeInsets.all(0.0),
                              title: Text(
                                "Login",
                                style: AppFont.semiBold.copyWith(
                                    fontWeight: FontWeight.bold, fontSize: 17),
                              ),
                              subtitle: Text(
                                '',
                                style: AppFont.regular.copyWith(
                                    fontWeight: FontWeight.w100,
                                    fontSize: 13,
                                    color: Colors.grey),
                              ),
                              trailing: IconButton(
                                onPressed: () {
                                  Get.toNamed("/login");
                                },
                                icon: Icon(
                                  Icons.arrow_forward_ios,
                                  size: 18,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
