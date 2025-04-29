import 'package:flutter/material.dart';
import 'package:great_places/widgets/image_input.dart';

class PlaceFormScreen extends StatefulWidget{
  @override
  State<PlaceFormScreen> createState() => _PlaceFormScreenState();
}

class _PlaceFormScreenState extends State<PlaceFormScreen> {
  TextEditingController _titleController = TextEditingController();

  void SubmitForm(){}

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
                  decoration: InputDecoration(
                    label: Text("Title")
                  ),  
                ),
                SizedBox(height: 10,),
                ImageInput()
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