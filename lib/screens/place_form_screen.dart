import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:great_places/providers/great_places.dart';
import 'package:great_places/widgets/image_input.dart';
import 'package:great_places/widgets/location_input.dart';
import 'package:provider/provider.dart';

class PlaceFormScreen extends StatefulWidget{
  @override
  State<PlaceFormScreen> createState() => _PlaceFormScreenState();
}

class _PlaceFormScreenState extends State<PlaceFormScreen> {
  TextEditingController _titleController = TextEditingController();
  File? _pickedImage;
  LatLng? _pickedPosition;

  void _selectedImage(File pickedImage){
    setState(() {
      _pickedImage = pickedImage;
    });
  }

  void _selectedPosition(LatLng pickedPosition){
    setState(() {
      _pickedPosition = pickedPosition;
    });
  }

  bool _isValidForm(){
    return _titleController.text.isNotEmpty && 
    _pickedImage != null && _pickedPosition != null;
  }

  void SubmitForm(){
    if(!_isValidForm()){return;}

    GreatPlaces greatPlaces = Provider.of<GreatPlaces>(context, listen: false);
    greatPlaces.addPlace(
      _titleController.text, 
      _pickedImage!,
      _pickedPosition!
    );

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
          "Novo local",
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
                SizedBox(height: 15),
                Container(
                  alignment: Alignment.center,
                  height: 70,
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: const Color.fromARGB(255, 39, 39, 39),
                  ),
                  child: TextField(
                    controller: _titleController,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                      label: Text("Titulo"),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 20)
                    ),  
                  ),
                ),
                SizedBox(height: 30,),
                ImageInput(_selectedImage)
              ],
            ),
            SizedBox(height: 30,),
            LocationInput(onSelectPosition: _selectedPosition),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 0, 120, 90),) 
                ),
                onPressed: () => _isValidForm() ? SubmitForm() : null,
                child: Text(
                  "Add",
                  style: TextStyle(
                    color: Colors.white
                  ),
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}