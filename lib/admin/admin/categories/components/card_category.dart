import 'package:flutter/material.dart';
import '../../../service/category_service.dart';
import 'package:get/get.dart';
import '../edit_category_screen.dart';
class CardCategory extends StatelessWidget {
  final String name;
  final String imageUrl;
  final String id;

  const CardCategory({Key? key, required this.name, required this.imageUrl, required this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Card(
      margin: const EdgeInsets.only(top: 10.0),
      color: Colors.white,
      elevation: 10,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15))),
      child: Stack(
        children: [
          Row( 
            mainAxisSize: MainAxisSize.min,
            children: [
          ClipRRect(
            borderRadius:const BorderRadius.all(Radius.circular(5)),
            child: Image.network(
              imageUrl.toString(),
              height: 300, // set the height to 200 pixels
              width: 100,
              fit: BoxFit.fill,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding( 
                padding: const EdgeInsets.only(left: 10.0, top: 10.0),
                child: Text(
                name.toString().toUpperCase(),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )],
          ),
        ]),
      Positioned(
        bottom: 0,
        right: 0,
        child: Row(children: [
          IconButton(
              onPressed: ()  {
                Get.to(() => EditCategoryScreen(), arguments: [
                  {"id": id},
                  {"name": name.toString()},
                  {"imageUrl": imageUrl.toString()}
                ]);
            },
            icon: const Icon(Icons.edit),
                      color: Colors.blue,

          ),
          IconButton(
                  onPressed: () async {
                    // Handle delete button press
                    var response = await CategoryService.deleteCategory(docId: id);
                    if (response.code != 200) {
                       ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(response.message.toString()),
                    backgroundColor: Colors.red,
                  ),
                );

                      }
                  },
                  icon: const Icon(Icons.delete),
                  color: Colors.red,
                ),
        ])
      ),
      ]),
    )
    ); 
  }
}
