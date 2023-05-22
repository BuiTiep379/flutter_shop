import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop_shoes/service/category_service.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

import '../base_page.dart';

class AddCategoryScreen extends BasePage {
  const AddCategoryScreen({super.key});

  @override
  _AddCategoryScreenState createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends BasePageState<AddCategoryScreen> {
  PlatformFile? pickedFile;
  UploadTask? uploadTask;
  TextEditingController _nameControler = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future saveCategory() async {
    final path = 'files/${pickedFile!.name}';
    final file = File(pickedFile!.path!);
    final ref = FirebaseStorage.instance.ref().child(path);
    uploadTask = ref.putFile(file);
    final snapshot = await uploadTask!.whenComplete(() => {});
    final urlDownload = await snapshot.ref.getDownloadURL();
    if (_formKey.currentState!.validate()) {
      var response = await CategoryService.addCategory(
          name: _nameControler.text, image: urlDownload);
      if (response.code != 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(response.message.toString()),
            backgroundColor: Colors.red,
          ),
        );
      } else {
        setState(() {
          _nameControler.text = "";
        });
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
  void initState() {
    super.initState();
    this.pageTitle = "Add Category";
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
        onPressed: saveCategory,
        child: Text(
          "Save",
          textAlign: TextAlign.center,
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

  Widget buildProgress() => StreamBuilder<TaskSnapshot>(
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data!;
            double progress = data.bytesTransferred / data.totalBytes;
            return SizedBox(
              height: 50,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  LinearProgressIndicator(
                    value: progress,
                    backgroundColor: Colors.grey,
                    color: Colors.blue,
                  ),
                  Center(
                      child: Text('${(100 * progress).roundToDouble()}%',
                          style: const TextStyle(color: Colors.white)))
                ],
              ),
            );
          } else {
            return const SizedBox(
              height: 50,
            );
          }
        },
        stream: uploadTask?.snapshotEvents,
      );
}
