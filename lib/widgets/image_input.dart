import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspath;


class ImageInput extends StatefulWidget{
  final Function(File) onSelectImage;

  ImageInput(this.onSelectImage);

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  var _storedImage = null;

  _takePicture() async{
    final ImagePicker _picker = ImagePicker();
    XFile? imageFile = await _picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600
    );

    if(imageFile == null) return;
    
    setState(() {
      _storedImage = File(imageFile.path);
    });

    final appDir = await syspath.getApplicationDocumentsDirectory();
    String fileName = path.basename(_storedImage.path);
    final savedImage = await _storedImage.copy('${appDir.path}/$fileName') ;

    widget.onSelectImage(savedImage);
  }

  @override
  Widget build(BuildContext context){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: [
          Container(
            width: 180,
            height: 100,
            decoration: BoxDecoration(
              border: Border.all(width: 2, color: Colors.grey)
            ),
            alignment: Alignment.center,
            child: _storedImage != null ? Image.file(
              _storedImage,
              width: double.infinity,
              fit: BoxFit.cover,
            ) : Text(
              "Tire uma foto!",
              style: TextStyle(
                color: Colors.white
              ),
            )
          ),
          SizedBox(
            width: 10,
          ),
          IconButton(
            icon: Icon(
              Icons.camera,
              color: Colors.white,
            ), 
            onPressed: (){
              _takePicture();
            },
          )
        ],
      ),
    );
  }
}