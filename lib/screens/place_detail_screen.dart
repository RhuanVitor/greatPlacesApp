import 'package:flutter/material.dart';
import 'package:great_places/models/place.dart';
import 'package:great_places/screens/map_screen.dart';
import 'package:great_places/utils/app_routes.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';

class PlaceDetailScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    Place place = ModalRoute.of(context)!.settings.arguments as Place;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white,),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.black,
        title: Text(
          place.title,
          style: TextStyle(
            color: Colors.white
          ),
        ),
      ),
      body: Column(
        spacing: 15,
        children: [
          InkWell(
            onTap: (){
              context.pushNamedTransition(
                type: PageTransitionType.fade,
                routeName: AppRoutes.PHOTO_VIEW,
                arguments:
                  {
                    'image': place.image,
                    'placeId' : place.id
                  }
              );
            },
            child: Hero(
              tag: place.id,
              child: Image.file(
                height: 300,
                width: double.infinity,
                fit: BoxFit.fitWidth,
                place.image!
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              spacing: 10,
              children: [
                Icon(
                  Icons.location_on, 
                  color: Colors.white,
                  size: 30,
                ),
                Flexible(
                  child: Text(
                    place.location!.address,
                    softWrap: true,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              spacing: 10,
              children: [
                Icon(Icons.date_range, color: Colors.grey,),
                Text(
                  DateFormat('dd/MM/yyyy hh:mm').format(place.pickDateTime),
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton.icon(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 0, 120, 90))
                ),
                icon: Icon(
                  Icons.map,
                  color: Colors.white,
                ),
                label: Text(
                  "Ver no mapa",
                  style: TextStyle(
                    color: Colors.white
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx){
                        return MapScreen(
                          initialLocation: PlaceLocation(
                            latitude: place.location!.latitude, longitude: place.location!.longitude,
                          ),
                          isReadOnly: true,
                          appBarTitle: place.location!.address,
                        );
                      }, 
                    )
                  );
                },
              )
            ],
          )
        ],
      ),
    );
  }
}