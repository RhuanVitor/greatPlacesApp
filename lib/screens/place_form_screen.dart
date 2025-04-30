import 'dart:io';

import 'package:flutter/material.dart';
import 'package:great_places/providers/great_places.dart';
import 'package:great_places/widgets/image_input.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class PlaceFormScreen extends StatefulWidget{
  @override
  State<PlaceFormScreen> createState() => _PlaceFormScreenState();
}

class _PlaceFormScreenState extends State<PlaceFormScreen> {
  TextEditingController _titleController = TextEditingController();
  File? _pickedImage;

  void _selectedImage(File pickedImage){
    _pickedImage = pickedImage;
  }

  void SubmitForm(){
    if(_titleController.text.isEmpty || _pickedImage == null){return;}

    GreatPlaces greatPlaces = Provider.of<GreatPlaces>(context, listen: false);
    greatPlaces.addPlace(_titleController.text, _pickedImage!);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ), 
          onPressed: (){
            Navigator.of(context).pop();
          }
        ),
        backgroundColor: Colors.black,
        title: Text(
          "New place",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.black
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              children: [
                TextField(
                  controller: _titleController,
                  style: TextStyle(
                    color: Colors.white
                  ),
                  decoration: InputDecoration(
                    label: Text("Title")
                  ),  
                ),
                SizedBox(height: 10,),
                ImageInput(_selectedImage)
              ],
            ),

            ElevatedButton(
              style: ButtonStyle(
              ),
              onPressed: SubmitForm,
              child: Text("Add"),
            )
          ],
        ),
      )
    );
  }
}