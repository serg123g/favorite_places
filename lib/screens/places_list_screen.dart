import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './add_place_screen.dart';
import '../providers/great_places.dart';
import './place_detail_screen.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Places'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
            },
          )
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<GreatPlaces>(context, listen: false)
            .fetchAndSetPlaces(),
        builder: (ctx, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? Center(child: CircularProgressIndicator())
            : Consumer<GreatPlaces>(
                child: Center(
                  child: const Text('Got no places yet, add some'),
                ),
                builder: (context, GreatPlaces, ch) =>
                    GreatPlaces.items.length <= 0
                        ? ch
                        : ListView.builder(
                            itemCount: GreatPlaces.items.length,
                            itemBuilder: (context, i) => ListTile(
                              leading: CircleAvatar(
                                backgroundImage:
                                    FileImage(GreatPlaces.items[i].image),
                              ),
                              title: Text(GreatPlaces.items[i].title),
                              subtitle:
                                  Text(GreatPlaces.items[i].location.address),
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                    PlaceDetailScreen.routeName,
                                    arguments: GreatPlaces.items[i].id);
                              },
                            ),
                          ),
              ),
      ),
    );
  }
}
