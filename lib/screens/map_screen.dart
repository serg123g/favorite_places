import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as latLng;

import '../models/place.dart';

class MapScreen extends StatefulWidget {
  final PlaceLocation initialLocation;
  final bool isSelecting;

  MapScreen(
      {this.initialLocation = const PlaceLocation(
        latitude: 37.422,
        longitude: -122.084,
      ),
      this.isSelecting = false});
  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  latLng.LatLng _pickedLocation;

  void _selectLocation(latLng.LatLng position) {
    setState(() {
      _pickedLocation = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Map'),
        actions: [
          if (widget.isSelecting)
            IconButton(
              onPressed: _pickedLocation == null
                  ? null
                  : () {
                      Navigator.of(context).pop(_pickedLocation);
                    },
              icon: Icon(Icons.check),
            ),
        ],
      ),
      body: FlutterMap(
        options: MapOptions(
          onTap: widget.isSelecting
              ? (tapPosition, point) {
                  setState(() {
                    _pickedLocation = point;
                  });
                }
              : null,
          center: latLng.LatLng(
            widget.initialLocation.latitude,
            widget.initialLocation.longitude,
          ),
          zoom: 13.0,
        ),
        layers: [
          TileLayerOptions(
            urlTemplate:
                "https://api.mapbox.com/styles/v1/patricio12/cl15fwyw5002p14ln20gh5bco/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoicGF0cmljaW8xMiIsImEiOiJjbDE1YzZidHUwcXl0M2x2MHhuYTJ4bDF0In0.Jb2s12kC0sKo2UwbE-gvhw",
            // subdomains: ['a', 'b', 'c'],
            additionalOptions: {
              'accessToken':
                  'pk.eyJ1IjoicGF0cmljaW8xMiIsImEiOiJjbDE1YzZidHUwcXl0M2x2MHhuYTJ4bDF0In0.Jb2s12kC0sKo2UwbE-gvhw',
              'id': 'mapbox.mapbox-streets-v8'
            },
            attributionBuilder: (_) {
              return Text("© OpenStreetMap contributors");
            },
          ),
          //adding the marker in the map
          MarkerLayerOptions(
            markers: (_pickedLocation == null && widget.isSelecting == true)
                ? []
                : [
                    Marker(
                      point: _pickedLocation ??
                          latLng.LatLng(
                            widget.initialLocation.latitude,
                            widget.initialLocation.longitude,
                          ),
                      builder: (ctx) => Container(
                        child: Icon(
                          Icons.location_on,
                        ),
                      ),
                    ),
                  ],
          ),
        ],
      ),
    );
  }
}
