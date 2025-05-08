import 'dart:io';

import 'package:flutter/material.dart';
import 'package:great_places/models/place.dart';
import 'package:photo_view/photo_view.dart';

class PhotoViewScreen extends StatelessWidget{

  @override
  Widget build (BuildContext context){
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    File image = args['image'];
    String placeId = args['placeId'];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back), 
          color: Colors.white,
          onPressed: (){
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Colors.black,
      ),
      body: Hero(tag: placeId, child: PhotoView(imageProvider: FileImage(image))),
    );
  }
}