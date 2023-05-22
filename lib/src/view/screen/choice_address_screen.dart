import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_shop_shoes/src/const/app_colors.dart';
import 'package:flutter_shop_shoes/src/const/app_font.dart';
import 'package:flutter_shop_shoes/src/data/model/address.dart';
import 'package:flutter_shop_shoes/src/data/service/user_service.dart';
import 'package:flutter_shop_shoes/src/router/router_path.dart';
import 'package:flutter_shop_shoes/src/view/screen/component/choiceaddress/address_scroll.dart';
import 'package:flutter_shop_shoes/src/viewmodel/address_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';

import '../../viewmodel/user_viewmodel.dart';
import 'component/addaddress/text_field_address.dart';

class ChoiceAddressScreen extends StatefulWidget {
  @override
  _ChoiceAddressScreenState createState() => _ChoiceAddressScreenState();
}

class _ChoiceAddressScreenState extends State<ChoiceAddressScreen> {
  bool checkbok = false;

  final phoneController = TextEditingController();
  final lineController = TextEditingController();

  final districtController = TextEditingController();
  final wardController = TextEditingController();

  static const List<String> paymentOptions = [
    'Thanh toán khi nhận hàng',
    'Thanh toán bằng Paypal'
  ];

  // Define the currently selected payment option
  String selectedOption = paymentOptions[0];

  @override
  Widget build(BuildContext context) {
    var userData = Provider.of<UserViewModel>(context);

    final addressViewModel =
        Provider.of<AddressViewModel>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.black,
          ),
        ),
        title: Text(
          "Shipping Address",
          style: AppFont.semiBold.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: ListView.builder(
            itemCount: 1,
            itemBuilder: (_, index) {
              return Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(.1),
                            blurRadius: 1,
                            spreadRadius: 1,
                            offset: Offset(2, 2),
                          ),
                        ]),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 40,
                        ),
                        TextFieldAddress(
                          textEditingController: phoneController,
                          lableText:
                              "${userData.items.values.toList()[0].phone}",
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        TextFieldAddress(
                          textEditingController: lineController,
                          lableText:
                              "${userData.items.values.toList()[0].line}",
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        TextFieldAddress(
                          textEditingController: districtController,
                          lableText:
                              "${userData.items.values.toList()[0].district}",
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        TextFieldAddress(
                          textEditingController: wardController,
                          lableText:
                              "${userData.items.values.toList()[0].ward}",
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        // CheckboxListTile(
                        //     title: Text(
                        //       "Use as the shipping address",
                        //       style: AppFont.regular.copyWith(
                        //         fontSize: 14,
                        //         fontWeight: FontWeight.w500,
                        //       ),
                        //     ),
                        //     controlAffinity: ListTileControlAffinity.leading,
                        //     activeColor: Colors.black,
                        //     contentPadding: EdgeInsets.all(0.0),
                        //     checkColor: Colors.white,
                        //     shape: RoundedRectangleBorder(),
                        //     value: checkbok,
                        //     onChanged: (value) {
                        //       setState(() {
                        //         checkbok = !checkbok;
                        //       });
                        //       // cartViewModel.checkBoxAddress(widget.address.addressTitle1!);
                        //     }),

                        RadioListTile(
                            value: checkbok,
                            contentPadding: EdgeInsets.all(0.0),
                            title: Text(
                              "Use as the shipping address",
                              style: AppFont.regular.copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            groupValue: checkbok,
                            onChanged: (value) {
                              setState(() {
                                checkbok != checkbok;
                              });
                            }),

                        // ElevatedButton(
                        //     onPressed: () async {
                        //       var response = await UserService.updateUser(
                        //           id: userData.items.values.toList()[0].id,
                        //           name: userData.items.values.toList()[0].name,
                        //           username: userData.items.values
                        //               .toList()[0]
                        //               .username,
                        //           password: userData.items.values
                        //               .toList()[0]
                        //               .password,
                        //           phone: phoneController.text.toString(),
                        //           line: lineController.text.toString(),
                        //           district: districtController.text.toString(),
                        //           ward: wardController.text.toString(),
                        //           docId: userData.items.values.toList()[0].uid);

                        //       if (response.code != 200) {
                        //         showDialog(
                        //             context: context,
                        //             builder: (context) {
                        //               return AlertDialog(
                        //                 content:
                        //                     Text(response.message.toString()),
                        //               );
                        //             });
                        //       } else {
                        //         showDialog(
                        //             context: context,
                        //             builder: (context) {
                        //               return AlertDialog(
                        //                 content:
                        //                     Text(response.message.toString()),
                        //               );
                        //             });
                        //       }
                        //     },
                        //     child: Text("change"))
                      ],
                    ),
                  ));
            },
          )),
      floatingActionButton: FloatingActionButton(
        // onPressed: () => Navigator.pushNamed(context, AddAddressScreens),
        onPressed: () async {
          var response = await UserService.updateUser(
              id: userData.items.values.toList()[0].id,
              name: userData.items.values.toList()[0].name,
              username: userData.items.values.toList()[0].username,
              password: userData.items.values.toList()[0].password,
              phone: phoneController.text.toString(),
              line: lineController.text.toString(),
              district: districtController.text.toString(),
              ward: wardController.text.toString(),
              docId: userData.items.values.toList()[0].uid);

          if (response.code != 200) {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: Text(response.message.toString()),
                  );
                });
          } else {
            final List<QueryDocumentSnapshot> userNotes = await UserService()
                .getUserUsername(
                    userData.items.values.toList()[0].username.toString());

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

            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: Text(response.message.toString()),
                  );
                });

            // Get.toNamed("/");
          }
        },
        backgroundColor: Colors.black,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
