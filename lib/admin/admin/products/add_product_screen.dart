import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';
import '../../service/product_admin_service.dart';
import 'package:flutter_shop_shoes/admin/admin/products/components/inputTextField.dart';
import 'package:path/path.dart' as path;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../base_page.dart';
import './components/dropDrownCustom.dart';
import './components/uploadImageButton.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import './components/filename.dart';
import '../../service/category_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddProductScreen extends BasePage {
  const AddProductScreen({super.key});

  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends BasePageState<AddProductScreen> {
  Stream<QuerySnapshot> categoryStream = CategoryService.readCategories();

  List<PlatformFile>? imageFiles = [];

  List<String> imageUrls = [];
  int imageCounts = 0;
  String selctFile = '';
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  // save product
  Future<String> _uploadMultipleFiles() async {
    String imageUrl = '';
    try {
      for (var i = 0; i < imageCounts; i++) {
        print("chay 2");
        UploadTask uploadTask;
        final path = 'files/${imageFiles![i].name}';
        print(path);
        final file = File(imageFiles![i].path!);
        print(file);
        final ref = FirebaseStorage.instance.ref().child(path);

        //uploadTask = ref.putFile(File(file.path));
        uploadTask = ref.putFile(File(file.path));
        final snapshot = await uploadTask!.whenComplete(() => {});
        imageUrl = await snapshot.ref.getDownloadURL();

        setState(() {
          imageUrls.add(imageUrl);
        });
      }
    } catch (e) {
      print(e);
    }
    return imageUrl;
  }

  Future saveProduct() async {
    await _uploadMultipleFiles();
    print('Uploaded Image URL ' + imageUrls.length.toString());
    if (_formKey.currentState!.validate()) {
      String priceCustom =
          _priceController.text.replaceAll(',', '').substring(1);
      print(_selectedCategory);
      print(_selectedBrand);
      print(_selectedColor);
      print(_selectedSize);
      print(_amountController.text);
      print(_nameController.text);
      print(_descriptionController.text);
      List<dynamic> thumbnails = [];
      for (var i = 0; i < 4; i++) {
        if (i < imageUrls.length) {
          thumbnails.add(imageUrls[i]);
        } else {
          thumbnails.add("");
        }
      }
      var response = await ProductService.addProduct(
        name: _nameController.text,
        thumbnail: thumbnails[0],
        thumbnail1: thumbnails[1],
        thumbnail2: thumbnails[2],
        thumbnail3: thumbnails[3],
        price: priceCustom,
        color: _selectedColor!,
        size: _selectedSize!,
        description: _descriptionController.text,
        amount: _amountController.text,
        brand: _selectedBrand!,
        category: _selectedCategory!,
        type: _selectedType!,
      );
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
      Get.back();
    }
  }

  // currency input formatter
  final dollarFormatter = CurrencyTextInputFormatter(
    locale: 'en_US',
    symbol: '\$',
    decimalDigits: 0,
  );

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // product typed_data
  final _productTypeList = [
    "normal",
    "bestsaller",
  ];
  String? _selectedType = "";
  // product size
  final _productSizeList = [
    "35",
    "36",
    "37",
    "38",
    "39",
    "40",
    "41",
    "42",
    "43"
  ];
  String? _selectedSize = "";

  // product category
  List<String> _productCategoryList = [];
  String? _selectedCategory = "";
  // product brand
  final _productBrandList = ["Nike", "Adidas", "Vans"];
  String? _selectedBrand = "";
  final _productColorList = [
    "black",
    "white",
    "red",
    "green",
    "blue",
    "yellow",
    "orange",
    "purple",
    "pink",
    "grey"
  ];
  String? _selectedColor = "";
  Future selectImage(int index) async {
    final fileResult = await FilePicker.platform.pickFiles(allowMultiple: true);
    if (fileResult != null) {
      fileResult.files.forEach((element) {
        setState(() {
          imageCounts += 1;
        });
      });
    }
    ;
    setState(() {
      imageFiles = fileResult!.files;
    });
  }

  Future<List<String>> getCategoryNames() async {
    CollectionReference categoryCollection =
        FirebaseFirestore.instance.collection('categories');
    QuerySnapshot querySnapshot = await categoryCollection.get();
    List<String> categoryNames = [];
    querySnapshot.docs.forEach((DocumentSnapshot document) {
      String categoryName = document.get('name');
      categoryNames.add(categoryName);
    });
    return categoryNames;
  }

  @override
  void initState() {
    super.initState();
    pageTitle = "Add Product";
    getCategoryNames().then((value) {
      setState(() {
        _productCategoryList = value;
        _selectedCategory = _productCategoryList[0];
      });
    });
    _selectedType = _productTypeList[0];
    _selectedSize = _productSizeList[0];
    _selectedBrand = _productBrandList[0];
    _selectedColor = _productColorList[0];
  }

  @override
  Widget pageUI() {
    final typeDropDown = DropdownButtonFormField(
      value: _selectedType,
      items: _productTypeList
          .map((e) => DropdownMenuItem(child: Text(e), value: e))
          .toList(),
      onChanged: (value) {
        setState(() {
          _selectedType = value;
        });
      },
      icon: const Icon(Icons.arrow_drop_down_circle, color: Colors.deepPurple),
      decoration: InputDecoration(
        labelText: "Product Type",
        prefixIcon: Icon(color: Colors.deepPurple, Icons.label),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      validator: (value) {
        if (value == null || value.toString().trim().isEmpty) {
          return 'Product type is required';
        }
      },
    );
    final categoryDropDown = _productCategoryList == null
        ? CircularProgressIndicator()
        : DropdownButtonFormField(
            value: _selectedCategory,
            items: _productCategoryList
                .map((e) => DropdownMenuItem(child: Text(e), value: e))
                .toList(),
            onChanged: (value) {
              setState(() {
                _selectedCategory = value;
              });
            },
            icon: const Icon(Icons.arrow_drop_down_circle,
                color: Colors.deepPurple),
            decoration: InputDecoration(
              labelText: "Product Categories",
              prefixIcon:
                  Icon(color: Colors.deepPurple, Icons.view_headline_rounded),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            validator: (value) {
              if (value == null || value.toString().trim().isEmpty) {
                return 'Product category is required';
              }
            },
          );

    final nameField = DynamicTextFormField(
      controller: _nameController,
      labelText: "Product Name",
      icon: Icons.article_rounded,
      isNumber: false,
    );
    final descriptionField = LimitedBox(
      maxHeight: 120,
      child: TextFormField(
        controller: _descriptionController,
        maxLines: null,
        autofocus: false,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Description is required';
          }
        },
        decoration: InputDecoration(
          labelText: "Product Description",
          prefixIcon:
              const Icon(color: Colors.deepPurple, Icons.description_rounded),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
    final amountField = DynamicTextFormField(
      controller: _amountController,
      labelText: "Product Amount",
      icon: Icons.inventory_2_rounded,
      isNumber: true,
    );

    final priceField = TextFormField(
      controller: _priceController,
      autofocus: false,
      inputFormatters: [dollarFormatter],
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Price is required';
        }
      },
      decoration: InputDecoration(
        labelText: "Product Price",
        prefixIcon:
            const Icon(color: Colors.deepPurple, Icons.price_change_rounded),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
    final colorDropDown = DropdownButtonFormField(
      value: _selectedColor,
      items: _productColorList
          .map((e) => DropdownMenuItem(child: Text(e), value: e))
          .toList(),
      onChanged: (value) {
        setState(() {
          _selectedColor = value;
        });
      },
      icon: const Icon(Icons.arrow_drop_down_circle, color: Colors.deepPurple),
      decoration: InputDecoration(
        labelText: "Product Color",
        prefixIcon: Icon(color: Colors.deepPurple, Icons.palette_rounded),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      validator: (value) {
        if (value == null || value.toString().trim().isEmpty) {
          return 'Color is required';
        }
      },
    );

    final sizeDropDown = DropdownButtonFormField(
      value: _selectedSize,
      items: _productSizeList
          .map((e) => DropdownMenuItem(child: Text(e), value: e))
          .toList(),
      onChanged: (value) {
        setState(() {
          _selectedSize = value;
        });
      },
      icon: const Icon(Icons.arrow_drop_down_circle, color: Colors.deepPurple),
      decoration: InputDecoration(
        labelText: "Product Size",
        prefixIcon: Icon(color: Colors.deepPurple, Icons.straight_rounded),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      validator: (value) {
        if (value == null || value.toString().trim().isEmpty) {
          return 'Size is required';
        }
      },
    );
    final brandDropDown = DropdownButtonFormField(
      value: _selectedBrand,
      items: _productBrandList
          .map((e) => DropdownMenuItem(child: Text(e), value: e))
          .toList(),
      onChanged: (value) {
        setState(() {
          _selectedBrand = value;
        });
      },
      icon: const Icon(Icons.arrow_drop_down_circle, color: Colors.deepPurple),
      decoration: InputDecoration(
        labelText: "Product Brand",
        prefixIcon: Icon(color: Colors.deepPurple, Icons.more_rounded),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      validator: (value) {
        if (value == null || value.toString().trim().isEmpty) {
          return 'Brand is required';
        }
      },
    );

    final SaveButton = ElevatedButton(
      onPressed: saveProduct,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Save Product'),
        ],
      ),
      style: ElevatedButton.styleFrom(
        primary: Colors.deepPurple,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
    final imageUploadButton = DynamicImageUploadButton(
      textLabel: 'Upload Product Image',
      index: 0,
      selectImage: selectImage,
    );

    final fileNameImage = DynamicImageWidget(
      imageFiles: imageFiles,
      onDelete: (index) {
        setState(() {
          imageFiles!.removeAt(index);
        });
      },
    );

    return Container(
        color: Colors.white,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  nameField,
                  const SizedBox(height: 20.0),
                  priceField,
                  const SizedBox(height: 20.0),
                  descriptionField,
                  const SizedBox(height: 20.0),
                  // color
                  colorDropDown,
                  const SizedBox(height: 20.0),
                  sizeDropDown,
                  const SizedBox(height: 20.0),
                  categoryDropDown,
                  const SizedBox(height: 20.0),
                  typeDropDown,
                  const SizedBox(height: 20.0),
                  brandDropDown,
                  const SizedBox(height: 20.0),
                  amountField,
                  const SizedBox(height: 20.0),
                  fileNameImage,
                  imageUploadButton,
                  /*
              fileNameImage1,
              image1UploadButton,
              fileNameImage2,
              image2UploadButton,
              fileNameImage3,
              image3UploadButton,
              const SizedBox(height: 20.0),
              */
                  SaveButton,
                ],
              ),
            ),
          ),
        ));
  }
}
