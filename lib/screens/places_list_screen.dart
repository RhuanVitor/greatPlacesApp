import 'package:flutter/material.dart';
import 'package:great_places/utils/app_routes.dart';

class PlacesListScreen extends StatelessWidget{

  Widget build (BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 5,
          children: [
            Text(
              "MyPlaces",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold
              ),
            ),
            Icon(
              Icons.location_pin,
              color: Colors.white,
            )
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.black
        ),
        child: Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        ),
      ),

      floatingActionButton: IconButton(
        style: ButtonStyle(
          fixedSize: MaterialStateProperty.all(
            Size(50, 50),),
          backgroundColor: MaterialStateProperty.all(
            Color.fromARGB(255, 0, 120, 90),
          ),
        ),
        icon: Icon(
          Icons.add,
          color: Colors.white,
        ), 
        onPressed: (){
          Navigator.of(context).pushNamed(
            AppRoutes.PLACE_FORM
          );
        }
      )
    );
  }
}

//const Color.fromARGB(255, 38, 125, 92)