import 'package:flutter/material.dart';
import 'package:great_places/models/place.dart';
import 'package:great_places/providers/great_places.dart';
import 'package:great_places/utils/app_routes.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class PlaceListItem extends StatelessWidget{
  late Place place;

  PlaceListItem({required this.place});

  @override
  Widget build (BuildContext context){
    GreatPlaces _placeList = Provider.of<GreatPlaces>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: InkWell(
        child: Row(
          children: [
            Hero(
              tag: place.id,
              child: Image.file(
                place.image!, 
                height: 60, 
                width: 60, 
                fit: BoxFit.cover,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              width: MediaQuery.of(context).size.width * 0.6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    place.title, 
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    overflow: TextOverflow.ellipsis,
                    // DateFormat('dd/MM/yyyy hh:mm').format(place.pickDateTime),
                    place.location!.address,
                    style: TextStyle(
                      color: const Color.fromARGB(255, 150, 150, 150)
                    ),
                  )
                ],
              ),
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: (){
                showDialog(
                  context: context, 
                  builder: (ctx){
                    return AlertDialog(
                      backgroundColor: const Color.fromARGB(255, 39, 39, 39),
                      title: Text(
                        "Deseja realmente apagar esse local?",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white
                        ),
                      ),
                      actions: [
                        TextButton(
                          child: Text("Não", style: TextStyle(color: Colors.grey),), 
                          onPressed: (){
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          child: Text("Sim", style: TextStyle(color: Colors.redAccent),), 
                          onPressed: (){
                            _placeList.deletePlace(place.id);
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  }
                );
              }, 
            )
          ],
        ),
        onTap: (){
          context.pushNamedTransition(
            type: PageTransitionType.fade,
            routeName:  AppRoutes.PLACE_DETAILS,
            arguments: place
          );
        },
      ),
    );
  }
}