import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:great_places/models/place.dart';
import 'package:great_places/screens/map_screen.dart';
import 'package:great_places/utils/location_util.dart';
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {
  final Function onSelectPosition;
  LocationInput({required this.onSelectPosition});

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _previewImageUrl;
  bool _previewImageIsLoading = false;
  Future<void> _getCurrentUserLocation() async{
    final locData = await Location().getLocation();
    final staticMapImageUrl = LocationUtil.generateLocationPreviewImage(
      latitude: locData.latitude!,
      longitude: locData.longitude!
    );

    setState(() {
      _previewImageUrl = staticMapImageUrl;
    });

    widget.onSelectPosition(
      LatLng(
        locData.latitude!,
        locData.longitude!,
      ),
    );
  }

  Future<void> _selectOnMap() async {
    final locData = await Location().getLocation();

    final selectedLocation = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx){
          return MapScreen(
            initialLocation: PlaceLocation(
              latitude: locData.latitude!, longitude: locData.longitude!
            ),
            appBarTitle: "Selecione um local...",
          );
        }, 
      )
    );

    if(selectedLocation == null) return;

    widget.onSelectPosition(selectedLocation);

    final staticMapImageUrl = LocationUtil.generateLocationPreviewImage(
      latitude: selectedLocation.latitude!,
      longitude: selectedLocation.longitude!
    );

    setState(() {
      _previewImageUrl = staticMapImageUrl;
    });
    
  }
  
  Widget build(BuildContext build){
    return Column(
      children: <Widget>[
        Container(
          height: 170,
          width: MediaQuery.of(context).size.width * 0.9,
          alignment: Alignment.center,

          decoration: BoxDecoration(
            // border: Border.all(width: 1, color: Colors.grey),
            borderRadius: BorderRadius.circular(20),
            color: const Color.fromARGB(255, 39, 39, 39),
          ),

          child: _previewImageUrl == null? 
           
           _previewImageIsLoading ?

           Center(
            child: CircularProgressIndicator(),
           ) : 
           Text(
              "Nenhum local selecionado!",
              style: TextStyle(
                color: Colors.white
              ),
            ) 
           

           : ClipRRect(
            borderRadius: BorderRadius.circular(20),
             child: Image.network(
              _previewImageUrl!,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
           ),
        ),
        SizedBox(height: 10,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
              label: Text(
                "Localização atual",
                style: TextStyle(
                  color: Colors.white
                ),
              ),
              icon: Icon(Icons.location_on, color: Colors.white),
              onPressed: ()async{
                setState(() {
                  _previewImageIsLoading = true; 
                });

                setState((){                  
                  _previewImageUrl = null; 
                });

                await _getCurrentUserLocation();

                setState(() {
                  _previewImageIsLoading = false;
                });
              },
            ),
            TextButton.icon(
              label: Text(
                "Selecione no mapa",
                style: TextStyle(
                  color: Colors.white
                ),
              ),
              icon: Icon(Icons.map, color: Colors.white),
              onPressed: (){
                _selectOnMap();
              },
            ),
          ],
        )
      ],
    );
  }
}