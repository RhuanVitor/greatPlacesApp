import 'package:flutter/material.dart';
import 'package:great_places/utils/location_util.dart';
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _previewImageUrl;
  Future<void> _getCurrentUserLocation() async{
    final locData = await Location().getLocation();
    final staticMapImageUrl = LocationUtil.generateLocationPreviewImage(
      latitude: locData.latitude!,
      longitude: locData.longitude!
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
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey)
          ),

          child: _previewImageUrl == null
           ? Text("No location selected!")
           : Image.network(
            _previewImageUrl!,
            fit: BoxFit.cover,
            width: double.infinity,
          ),
        ),
        Row(
          children: [
            TextButton.icon(
              label: Text("Current Location"),
              icon: Icon(Icons.location_on),
              onPressed: _getCurrentUserLocation,
              ),
            TextButton.icon(
              label: Text("Select on map"),
              icon: Icon(Icons.map),
              onPressed: (){},
              ),
          ],
        )
      ],
    );
  }
}