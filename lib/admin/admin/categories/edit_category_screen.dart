import 'dart:io';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop_shoes/service/category_service.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../base_page.dart';

class EditCategoryScreen extends BasePage {
  @override
  _EditCategoryScreenState createState() => _EditCategoryScreenState();
}

class _EditCategoryScreenState extends BasePageState<EditCategoryScreen> {
  dynamic argumentData = Get.arguments;
  PlatformFile? pickedFile;
  UploadTask? uploadTask;
  final TextEditingController _nameControler = TextEditingController();

  String id = "";
  String name = "";
  String imageUrl = "";

  @override
  void initState() {
    super.initState();
    if (argumentData != null) {
      print(argumentData);
      id = argumentData[0]['id'];
      name = argumentData[1]['name'];
      imageUrl = argumentData[2]['imageUrl'];
    }
    _nameControler.text = name;
    pageTitle = "Edit Category";
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future editCategory() async {
    String urlDownload = "";
    if (pickedFile == null) {
      urlDownload = imageUrl;
    } else {
      final path = 'files/${pickedFile!.name}';
      final file = File(pickedFile!.path!);
      final ref = FirebaseStorage.instance.ref().child(path);
      uploadTask = ref.putFile(file);
      final snapshot = await uploadTask!.whenComplete(() => {});
      urlDownload = await snapshot.ref.getDownloadURL();
    }

    if (_formKey.currentState!.validate()) {
      var response = await CategoryService.updateCategory(
          name: _nameControler.text, image: urlDownload, docId: id);
      if (response.code != 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(response.message.toString()),
            backgroundColor: Colors.red,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(response.message.toString()),
            backgroundColor: Colors.green,
          ),
        );
      }
    }
    Get.back();
  }

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles();
    print(result);
    if (result == null) return;
    setState(() {
      pickedFile = result.files.first;
    });
  }

  @override
  Widget pageUI() {
    final nameField = TextFormField(
        controller: _nameControler,
        autofocus: false,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Name is required';
          }
        },
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Name",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(15.0))));
    final uploadButton = ElevatedButton(
        onPressed: selectFile,
        child: const Text(
          "Select file",
        ));
    final SaveButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(15.0),
      color: Theme.of(context).primaryColor,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () => editCategory(),
        child: Text(
          "Edit",
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );

    return Container(
        color: Colors.white,
        padding: const EdgeInsets.only(left: 10, right: 10, top: 15),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              nameField,
              const SizedBox(height: 25.0),
              imageUrl == null
                  ? Icon(Icons.category, size: 100)
                  : Image.network(imageUrl, height: 100),
              uploadButton,
              if (pickedFile != null) Text(pickedFile!.name),
              const SizedBox(
                height: 15,
              ),
              SaveButon,
              const SizedBox(height: 15.0),
            ],
          ),
        ));
  }
}
