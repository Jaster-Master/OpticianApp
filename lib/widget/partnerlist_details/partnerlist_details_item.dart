import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:opticianapp/widget/partnerlist_details/partnerlist_available_appointments.dart';
import 'package:opticianapp/widget/partnerlist_details/partnerlist_locations.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../default_properties.dart';
import '../../../main.dart';
import '../../../model/location.dart';
import '../../../model/optician.dart';

class PartnerDetailsItemView extends StatefulWidget {
  Optician partner;

  PartnerDetailsItemView(this.partner, {super.key});

  @override
  State<StatefulWidget> createState() => PartnerDetailsItemViewState();
}

class PartnerDetailsItemViewState extends State<PartnerDetailsItemView> {
  @override
  Widget build(BuildContext context) {
    var favouriteLocationId =
        OpticianApp.user?.favouriteOpticianLocations[widget.partner.id];
    Location favouriteLocation =
        favouriteLocationId == -1 || favouriteLocationId == null
            ? widget.partner.locations[0]
            : widget.partner.locations
                .singleWhere((element) => element.id == favouriteLocationId);
    return Container(
      margin: EdgeInsets.all(DefaultProperties.defaultPadding),
      padding: EdgeInsets.all(DefaultProperties.defaultPadding),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(DefaultProperties.defaultRounded),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.25),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 10.0)),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(widget.partner.name,
                  style: TextStyle(fontSize: DefaultProperties.fontSize1)),
              Spacer(),
              IconButton(
                padding: EdgeInsets.all(0),
                onPressed: () => onMakeFavouritePress(widget.partner),
                icon: Icon(
                  widget.partner.id == OpticianApp.user?.favouriteOpticianId
                      ? Icons.star
                      : Icons.star_outline,
                  color: DefaultProperties.blueColor,
                ),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Material(
            child: InkWell(
              onTap: () => goToLocations(context, widget.partner),
              child: Container(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(color: Colors.grey.withOpacity(0.25)),
                      top: BorderSide(color: Colors.grey.withOpacity(0.25))),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          right: DefaultProperties.defaultPadding),
                      child: Icon(Icons.location_on_outlined),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            "${favouriteLocation.street} ${favouriteLocation.streetNumber}",
                            style: TextStyle(
                                fontSize: DefaultProperties.fontSize2)),
                        Text(
                            "${favouriteLocation.zipCode} ${favouriteLocation.city}",
                            style: TextStyle(
                                fontSize: DefaultProperties.fontSize2))
                      ],
                    ),
                    Spacer(),
                    Icon(Icons.keyboard_arrow_right),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.all(DefaultProperties.lessPadding),
                child: SizedBox(
                  height: 50,
                  child: OutlinedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith(
                          (states) => DefaultProperties.lightBlueColor),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              DefaultProperties.defaultRounded))),
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              right: DefaultProperties.defaultPadding),
                          child: Icon(Icons.phone_outlined),
                        ),
                        Text(widget.partner.phoneNumber,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: DefaultProperties.fontSize3))
                      ],
                    ),
                    onPressed: () {
                      launchUrlString("tel:${widget.partner.phoneNumber}");
                    },
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(DefaultProperties.lessPadding),
                child: SizedBox(
                  height: 50,
                  child: OutlinedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith(
                          (states) => DefaultProperties.lightBlueColor),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              DefaultProperties.defaultRounded))),
                    ),
                    child: Row(children: [
                      Padding(
                        padding: EdgeInsets.only(
                            right: DefaultProperties.defaultPadding),
                        child: Icon(Icons.mail_outlined),
                      ),
                      Text(widget.partner.email,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: DefaultProperties.fontSize3)),
                    ]),
                    onPressed: () {
                      launchUrlString("mailto:${widget.partner.email}");
                    },
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(DefaultProperties.lessPadding),
                child: SizedBox(
                  height: 50,
                  child: OutlinedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith(
                          (states) => DefaultProperties.lightBlueColor),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              DefaultProperties.defaultRounded))),
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              right: DefaultProperties.defaultPadding),
                          child: Icon(Icons.public_outlined),
                        ),
                        Text(widget.partner.website,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: DefaultProperties.fontSize3)),
                      ],
                    ),
                    onPressed: () {
                      launchUrl(Uri.parse("https://${widget.partner.website}"));
                    },
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(DefaultProperties.lessPadding),
                child: SizedBox(
                  height: 50,
                  child: OutlinedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith(
                          (states) => DefaultProperties.lightBlueColor),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              DefaultProperties.defaultRounded))),
                    ),
                    child: Row(children: [
                      Padding(
                          padding: EdgeInsets.only(
                              right: DefaultProperties.defaultPadding),
                          child: Icon(Icons.calendar_today_outlined)),
                      Text("Freie Termine",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: DefaultProperties.fontSize3)),
                    ]),
                    onPressed: () => {showFreeDates(context, widget)},
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(DefaultProperties.lessPadding),
                child: SizedBox(
                  height: 50,
                  child: OutlinedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith(
                          (states) => DefaultProperties.lightBlueColor),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              DefaultProperties.defaultRounded))),
                    ),
                    child: Row(
                      children: [
                        Padding(
                            padding: EdgeInsets.only(
                                right: DefaultProperties.defaultPadding),
                            child: Icon(Icons.person_add_outlined)),
                        Text("Kontaktdaten speichern",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: DefaultProperties.fontSize3))
                      ],
                    ),
                    onPressed: () => {_saveContact(widget)},
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _saveContact(PartnerDetailsItemView widget) async {
    try {
      PermissionStatus permission = await Permission.contacts.status;
      if (permission != PermissionStatus.granted) {
        await Permission.contacts.request();
      }

      permission = await Permission.contacts.status;
      if (permission == PermissionStatus.granted) {
        await ContactsService.addContact(Contact(
            givenName: widget.partner.name,
            company: widget.partner.website,
            postalAddresses: _allPostalAddresses(widget),
            emails: [
              Item(label: 'Work', value: widget.partner.email)
            ],
            phones: [
              Item(label: 'Mobile', value: widget.partner.phoneNumber)
            ]));
      }
    } catch (e) {
      print(e);
    }
  }

  void onMakeFavouritePress(Optician partner) {
    setState(() {
      if (OpticianApp.user?.favouriteOpticianId == partner.id) {
        OpticianApp.user?.favouriteOpticianId = -1;
      } else {
        OpticianApp.user?.favouriteOpticianId = partner.id;
      }
    });
  }

  void goToLocations(BuildContext context, Optician partner) {
    var result = Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PartnerLocationsView(partner),
      ),
    );
    result.then((value) => setState(() {}));
  }

  void showFreeDates(BuildContext context, PartnerDetailsItemView widget) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PartnerAvailableAppointmentsView(widget.partner),
      ),
    );
  }

  _allPostalAddresses(PartnerDetailsItemView widget) {
    List<PostalAddress> items = [];
    for (var value in widget.partner.locations) {
      items.add(PostalAddress(
          label: "Address",
          street: "${value.street} ${value.streetNumber}",
          city: value.city,
          country: value.country,
          postcode: value.zipCode));
    }
    return items;
  }
}
