import 'package:flutter/material.dart';
import 'package:great_places/models/place.dart';
import 'package:intl/intl.dart';

class PlaceListItem extends StatelessWidget{
  late Place place;

  PlaceListItem({required this.place});

  @override
  Widget build (BuildContext context){
    return InkWell(
      child: Container(
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.file(place.image!, height: 80, width: 80, fit: BoxFit.cover,)
            ),
            Column(
              children: [
                Text(
                  place.title, 
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                Text(
                  DateFormat('dd/MM/yyyy hh:mm').format(place.pickDateTime),
                  style: TextStyle(
                    color: const Color.fromARGB(255, 150, 150, 150)
                  ),
                )
              ],
            ),
            IconButton(onPressed: (){}, icon: Icon(Icons.delete))
          ],
        ),
      ),
      onTap: (){
      },
    );
  }
}