import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:file_picker/file_picker.dart';
class DynamicImageWidget extends StatelessWidget {
  final List<PlatformFile>? imageFiles;
  final void Function(int) onDelete;

  const DynamicImageWidget({Key? key, this.imageFiles, required this.onDelete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return imageFiles != null
        ? 
        Column(
  children: [
    SizedBox(
      height: imageFiles == 0 ? 30 : imageFiles!.length*50, // set the desired height of the list view
      child: ListView.builder(
        itemCount: imageFiles!.length,
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.all(8),
            margin: EdgeInsets.symmetric(vertical: 4),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(Icons.image, color: Colors.grey[600]),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    path.basename(imageFiles![index].name),
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // Implement onDelete method here
                    onDelete(index);
                  },
                  child: Icon(Icons.delete, color: Colors.red),
                ),
              ],
            ),
          );
        },
      ),
    ),
  ],
)

         : Container();
            
    /*
        ? Container(
            padding: EdgeInsets.all(8),
            margin: EdgeInsets.symmetric(vertical: 4),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(Icons.image, color: Colors.grey[600]),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    path.basename(imageFile!.name),
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                GestureDetector(
                  onTap: onDelete,
                  child: Icon(Icons.delete, color: Colors.red),
                ),
              ],
            ),
          )
        : Container();
        */
  }
}

