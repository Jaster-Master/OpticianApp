import 'package:flutter/material.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:opticianapp/default_properties.dart';
import 'package:opticianapp/main.dart';
import 'package:opticianapp/model/location.dart';
import 'package:opticianapp/model/optician.dart';
import 'package:opticianapp/widget/partnerlist_details/partnerlist_locations.dart';

class PartnerLocationListItem extends StatefulWidget {
  PartnerLocationsViewState currentState;
  Optician partner;
  int index;

  PartnerLocationListItem(this.currentState, this.partner, this.index,
      {super.key});

  @override
  State<StatefulWidget> createState() => PartnerLocationListItemState();
}

class PartnerLocationListItemState extends State<PartnerLocationListItem> {
  @override
  Widget build(BuildContext context) {
    var location = widget.partner.locations[widget.index];
    var isFavourite =
        OpticianApp.user?.favouriteOpticianLocations[widget.partner.id] ==
            location.id;
    return InkWell(
      onTap: () => openMap(location),
      child: Container(
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: DefaultProperties.lightGrayColor,
              width: 1,
            ),
          ),
        ),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(location.city,
                    style: TextStyle(fontSize: DefaultProperties.fontSize3)),
                Text(location.street + " " + location.streetNumber,
                    style: TextStyle(fontSize: DefaultProperties.fontSize4))
              ],
            ),
            Spacer(),
            IconButton(
                onPressed: () =>
                    {makeLocationFavourite(widget.partner, location)},
                icon: Icon(isFavourite ? Icons.star : Icons.star_outline,
                    color: DefaultProperties.blueColor)),
            IconButton(
                onPressed: () => openMap(location),
                icon: Icon(Icons.keyboard_arrow_right))
          ],
        ),
      ),
    );
  }

  void makeLocationFavourite(Optician partner, Location location) {
    widget.currentState.setState(() {
      if (OpticianApp.user?.favouriteOpticianLocations[partner.id] ==
          location.id) {
        OpticianApp.user?.favouriteOpticianLocations[partner.id] = -1;
      } else {
        OpticianApp.user?.favouriteOpticianLocations[partner.id] = location.id;
      }
    });
  }

  void openMap(Location location) {
    MapsLauncher.launchQuery(
        "${location.zipCode} ${location.city}, ${location.street} ${location.streetNumber}, ${location.country}");
  }
}
