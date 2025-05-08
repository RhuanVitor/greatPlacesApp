import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:great_places/models/place.dart';

class MapScreen extends StatefulWidget{
  final PlaceLocation initialLocation;
  final bool isReadOnly;
  final String? appBarTitle;

  MapScreen({
    required this.initialLocation,
    this.isReadOnly = false,
    this.appBarTitle
  });

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? _pickedPosition;

  void _selectPosition(LatLng position){
    setState(() {
      _pickedPosition = position;
    });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.close,
            color: Colors.white,
          ),
          onPressed: (){
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Color.fromARGB(255, 0, 120, 90),
        title: Text(
          overflow: TextOverflow.fade,
          widget.appBarTitle ?? "Mapa",
          style: TextStyle(
            color: Colors.white
          ),
        ),
        actions: [
          if(!widget.isReadOnly)
          IconButton(
            icon: Icon(Icons.check, color: Colors.white,),
            onPressed: 
              _pickedPosition == null ? null : (){
                Navigator.of(context).pop(_pickedPosition); 
              }
          )
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          zoom: 18,
          target: LatLng(
            widget.initialLocation.latitude, 
            widget.initialLocation.longitude
          )
        ),
        onLongPress: widget.isReadOnly ? null : _selectPosition,
        markers: _pickedPosition == null ? {
          Marker(
            markerId: MarkerId('p1'),
            position: LatLng(widget.initialLocation.latitude, widget.initialLocation.longitude) 
          )
        } : {
          Marker(
            markerId: MarkerId('p1'),
            position: _pickedPosition!
          )
        },
      ),
    );
  }
}