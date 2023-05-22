import 'dart:io';
import 'dart:async';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './components/inputTextField.dart';
import '../../service/product_admin_service.dart';
import '../base_page.dart';
import '../../model/product_model.dart';
import './components/uploadImageButton.dart';
import './components/dropDrownCustom.dart';

class EditProductScreen extends BasePage {
  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends BasePageState<EditProductScreen> {
  List<PlatformFile>? imageFiles = [];
  final _formKey = GlobalKey<FormState>();
  dynamic argumentData = Get.arguments;
  Product? _productModel;
  int imageCounts = 0;
  List<String?> _imageUrls = [];
  String id = "";
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

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
  String? _selectedColor;
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
  String? _selectedSize;

  // product category
  List<String> _productCategoryList = [];
  String? _selectedType = "";
  final _productTypeList = [
    "normal",
    "bestsaller",
  ];

  String? _selectedCategory = "";
  // product brand
  final _productBrandList = ["Nike", "Vans", "Adidas"];
  String? _selectedBrand;

  final dollarFormatter = CurrencyTextInputFormatter(
    locale: 'en_US',
    symbol: '\$',
    decimalDigits: 0,
  );
  Future<String> _uploadMultipleFiles() async {
    String imageUrl = '';
    print('chay upload');
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
          _imageUrls.add(imageUrl);
        });
      }
    } catch (e) {
      print(e);
    }
    return imageUrl;
  }

  Future saveProduct() async {
    print('Uploaded Image URL ' + _imageUrls.length.toString());
    String priceCustom = _priceController.text.replaceAll(',', '').substring(1);
    print(_selectedCategory);
    print(_selectedBrand);
    print(_selectedColor);
    print(_selectedSize);
    print(_amountController.text);
    print(_nameController.text);
    print(_descriptionController.text);
    print(priceCustom);
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
        if (i < _imageUrls.length) {
          thumbnails.add(_imageUrls[i]);
        } else {
          thumbnails.add("");
        }
      }
      var response = await ProductService.updateProduct(
        docId: id,
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

  void showCustomDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          title: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
          ),
          content: Text(
            message,
            style: TextStyle(
              fontSize: 16.0,
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                "OK",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.deepPurple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Future selectImage(int index) async {
    final fileResult = await FilePicker.platform.pickFiles(allowMultiple: true);
    if (fileResult != null) {
      // check if the number of selected images is equal to 4 - _imageUrls
      if (fileResult.files.length <= 4 - _imageUrls.length) {
        setState(() async {
          imageCounts += fileResult.files.length;
          imageFiles = fileResult.files;
          await _uploadMultipleFiles();
        });
      } else {
        // show an error message to the user
        showCustomDialog(
            context, "Error", "Please select ${4 - _imageUrls.length} images.");
      }
    }
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
    if (argumentData != null) {
      id = argumentData[0];
      ProductService.getProductById(id).then((productSnapshot) {
        _productModel = Product.fromSnapshot(productSnapshot);
        setState(() {
          _nameController.text = _productModel!.name;
          _descriptionController.text = _productModel!.description;
          _amountController.text = _productModel!.amount;
          _priceController.text =
              dollarFormatter.format(_productModel!.price).toString();
          _selectedColor = _productModel!.color.toString();
          _selectedCategory = _productModel!.category.toString();
          _selectedBrand = _productModel!.brand.toString();
          _selectedSize = _productModel!.size.toString();
          _selectedType = _productModel!.type.toString();
          _imageUrls = [
            if (_productModel!.thumbnail.isNotEmpty) _productModel!.thumbnail,
            if (_productModel!.thumbnail1.isNotEmpty) _productModel!.thumbnail1,
            if (_productModel!.thumbnail2.isNotEmpty) _productModel!.thumbnail2,
            if (_productModel!.thumbnail3.isNotEmpty) _productModel!.thumbnail3,
          ];
          imageCounts =
              _imageUrls.length; // Set other fields' initial values here
        });
      });
    }
    getCategoryNames().then((value) {
      setState(() {
        _productCategoryList = value;
      });
    });
    print(_imageUrls.length.toString());
    pageTitle = "Edit Product";
  }

  Widget pageUI() {
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
        labelText: "Product Colors",
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
    final categoryDropDown = DropdownButtonFormField(
      value: _selectedCategory,
      items: _productCategoryList
          .map((e) => DropdownMenuItem(child: Text(e), value: e))
          .toList(),
      onChanged: (value) {
        setState(() {
          _selectedCategory = value;
        });
      },
      icon: const Icon(Icons.arrow_drop_down_circle, color: Colors.deepPurple),
      decoration: InputDecoration(
        labelText: "Product Category",
        prefixIcon: Icon(color: Colors.deepPurple, Icons.view_headline_rounded),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      validator: (value) {
        if (value == null || value.toString().trim().isEmpty) {
          return 'Category is required';
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
          _selectedSize = value!;
        });
      },
      icon: const Icon(Icons.arrow_drop_down_circle, color: Colors.deepPurple),
      decoration: InputDecoration(
        labelText: "Product Sizes",
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
    final imageUploadButton = ElevatedButton(
      onPressed: () => selectImage(0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.upload),
          SizedBox(width: 8),
          Text("Upload Product Image"),
        ],
      ),
      style: ElevatedButton.styleFrom(
        primary: Colors.deepPurple,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    final saveButton = ElevatedButton(
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

    return Container(
        color: Colors.white,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize:
                    MainAxisSize.min, // set mainAxisSize to MainAxisSize.min
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
                  brandDropDown,
                  const SizedBox(height: 20.0),
                  typeDropDown,
                  const SizedBox(height: 20.0),
                  amountField,
                  const SizedBox(height: 20.0),
                  // render list of thumbnail images here
                  // wrap the ListView in an Expanded widget
                  SizedBox(
                    width: double.infinity,
                    height: 110,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: _imageUrls.length,
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(
                            width:
                                10.0); // set the width of the separator to add padding
                      },
                      itemBuilder: (BuildContext context, int index) {
                        return buildThumbnailImage(_imageUrls[index], () {
                          setState(() {
                            _imageUrls.removeAt(index);
                          });
                        });
                      },
                    ),
                    /*
            child: Row(
              children: [
                if (_productModel?.thumbnail != null)
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: buildThumbnailImage(_productModel!.thumbnail),
                  ),
                if (_productModel?.thumbnail1 != null)
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: buildThumbnailImage(_productModel!.thumbnail1),
                  ),
                if (_productModel?.thumbnail2 != null)
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: buildThumbnailImage(_productModel!.thumbnail2),
                  ),
                if (_productModel?.thumbnail3 != null)
                  Padding(
                    padding: const EdgeInsets.only(right: 0),
                    child: buildThumbnailImage(_productModel!.thumbnail3),
                  ),
                // add more images here if needed
              ],
            ),
            */
                  ),
                  if (_imageUrls.length < 4) imageUploadButton,
                  saveButton,
                ],
              ),
            ),
          ),
        ));
  }

  Widget buildThumbnailImage(String? imageUrl, VoidCallback onDelete) {
    if (imageUrl != null && imageUrl.isNotEmpty) {
      return Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: SizedBox(
              width: 85.0, // set a fixed width
              height: 82.0, // set a fixed height
              child: AspectRatio(
                aspectRatio: 1.0, // set the aspect ratio to 1:1
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(imageUrl),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: IconButton(
              icon: Icon(Icons.delete),
              onPressed: onDelete,
              color: Colors.red,
            ),
          ),
        ],
      );
    } else {
      return Container(); // return an empty container if imageUrl is null or empty
    }
  }
}
