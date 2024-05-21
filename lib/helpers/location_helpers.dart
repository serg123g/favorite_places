import 'dart:convert';

import 'package:http/http.dart' as http;

const MAPBOX_TOKEN =
    'pk.eyJ1IjoicGF0cmljaW8xMiIsImEiOiJjbDE1YzZidHUwcXl0M2x2MHhuYTJ4bDF0In0.Jb2s12kC0sKo2UwbE-gvhw';

class LocationHelper {
  static String generateLocationPreviewImage({
    double latitude,
    double longitude,
  }) {
    return 'https://api.mapbox.com/styles/v1/mapbox/streets-v11/static/pin-l($longitude,$latitude)/$longitude,$latitude,14.25,0,0/600x300?access_token=$MAPBOX_TOKEN';
  }

  static Future<String> getPlaceAddress(double lat, double lng) async {
    var url = Uri.parse(
        'https://api.mapbox.com/geocoding/v5/mapbox.places/$lng,$lat.json?access_token=$MAPBOX_TOKEN');
    final response = await http.get(url);
    // print('la respuesta');
    // print(json.decode(response.body)['features'][0]['place_name']);
    return json.decode(response.body)['features'][0]['place_name'];
  }
}
