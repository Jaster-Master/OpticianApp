import 'package:clean_calendar/clean_calendar.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:opticianapp/default_properties.dart';
import 'package:opticianapp/main.dart';
import 'package:opticianapp/model/location.dart';
import 'package:opticianapp/model/optician.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class PartnerDetailsView extends StatefulWidget {
  Optician partner;

  PartnerDetailsView(this.partner, {super.key});

  @override
  State<StatefulWidget> createState() => PartnerDetailsViewState();
}

class PartnerDetailsViewState extends State<PartnerDetailsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(right: DefaultProperties.morePadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                      onPressed: () => {onBackButton()},
                      icon: Icon(Icons.arrow_back)),
                  Text(
                    "Zurück",
                    style: TextStyle(fontSize: DefaultProperties.fontSize2),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(DefaultProperties.lessPadding),
              child: Text(
                widget.partner.name,
                style: TextStyle(fontSize: DefaultProperties.fontSize1),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(DefaultProperties.lessPadding),
              child: Text(
                "",
                style: TextStyle(
                    fontSize: DefaultProperties.fontSize2,
                    color: DefaultProperties.blueColor),
              ),
            ),
            PartnerDetailsItemView(widget.partner),
          ],
        ),
      ),
    );
  }

  void onBackButton() {
    Navigator.pop(context);
  }
}

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
        builder: (context) => PartnerDateView(),
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

class PartnerLocationsView extends StatefulWidget {
  Optician partner;

  PartnerLocationsView(this.partner, {super.key});

  @override
  State<StatefulWidget> createState() => PartnerLocationsViewState();
}

class PartnerLocationsViewState extends State<PartnerLocationsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                    onPressed: () => {Navigator.pop(context)},
                    icon: Icon(Icons.arrow_back)),
                Text("Zurück",
                    style: TextStyle(fontSize: DefaultProperties.fontSize2)),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(DefaultProperties.lessPadding),
              child: Text(
                widget.partner.name,
                style: TextStyle(fontSize: DefaultProperties.fontSize1),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(DefaultProperties.lessPadding),
              child: Text(
                "", // I heul
                style: TextStyle(
                    fontSize: DefaultProperties.fontSize2,
                    color: DefaultProperties.blueColor),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(DefaultProperties.morePadding),
                child: ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.white, Colors.white.withOpacity(0.05)],
                      stops: [0.75, 1],
                      tileMode: TileMode.mirror,
                    ).createShader(bounds);
                  },
                  child: NotificationListener<OverscrollIndicatorNotification>(
                    onNotification: (overscroll) {
                      overscroll.disallowIndicator();
                      return true;
                    },
                    child: ListView.builder(
                      itemCount: widget.partner.locations.length + 1,
                      itemBuilder: (context, index) {
                        Widget item = SizedBox.shrink();
                        if (index == 0) {
                          item = Container(
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: DefaultProperties.lightGrayColor,
                                  width: 1,
                                ),
                              ),
                            ),
                            child: Text("Filialen",
                                style: TextStyle(
                                    fontSize: DefaultProperties.fontSize2)),
                          );
                        } else {
                          index--;
                          item = PartnerLocationListItem(
                              this, widget.partner, index);
                        }
                        return Padding(
                          padding: EdgeInsets.only(
                              bottom:
                                  index == widget.partner.locations.length - 1
                                      ? DefaultProperties.doubleMorePadding
                                      : 0),
                          child: item,
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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

class PartnerDateView extends StatefulWidget {
  PartnerDateView({super.key});

  @override
  State<StatefulWidget> createState() => PartnerDateViewState();
}

class PartnerDateViewState extends State<PartnerDateView> {
  @override
  Widget build(BuildContext context) {
    List<DateTime> selectedDates = getDates();
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                    onPressed: () => {Navigator.pop(context)},
                    icon: Icon(Icons.arrow_back)),
                Text("Zurück",
                    style: TextStyle(fontSize: DefaultProperties.fontSize2)),
              ],
            ),
            CleanCalendar(
              selectedDatesProperties: DatesProperties(
                datesDecoration: DatesDecoration(
                  datesBackgroundColor: Colors.lightGreen.shade100,
                  datesBorderColor: Colors.green,
                  datesTextColor: Colors.black,
                ),
              ),
              leadingTrailingDatesProperties: DatesProperties(
                disable: true,
                hide: true,
              ),
              generalDatesProperties: DatesProperties(
                datesDecoration: DatesDecoration(
                  datesBackgroundColor: Colors.red.shade100,
                  datesBorderColor: Colors.red,
                  datesTextColor: Colors.white,
                ),
              ),
              selectedDates: selectedDates,
            ),
          ],
        ),
      ),
    );
  }

  void showBookDialog() {
    TextEditingController date = TextEditingController();
    date.text = DefaultProperties.defaultDateFormat.format(DateTime.now());
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            scrollable: true,
            title: Text('Erinnerung erstellen'),
            content: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                child: Column(
                  children: <Widget>[
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Titel',
                        icon: Icon(Icons.title),
                      ),
                    ),
                    TextField(
                      controller: date,
                      decoration: InputDecoration(
                        labelText: 'Datum',
                        icon: Icon(Icons.calendar_today),
                      ),
                      readOnly: true,
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2101));

                        if (pickedDate != null) {
                          String formattedDate = DefaultProperties
                              .defaultDateFormat
                              .format(pickedDate);
                          setState(() {
                            date.text = formattedDate;
                          });
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              TextButton(
                  child: Text("Abbrechen"),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              TextButton(
                  child: Text("Buchen"),
                  onPressed: () {
                    setState(() {
                      // TODO book
                    });

                    Navigator.pop(context);
                  }),
            ],
          );
        });
  }

  onBackButton() {}

  getDates() {
    return [
      DateTime(2022, 12, 5),
      DateTime(2022, 12, 6),
      DateTime(2022, 12, 7),
      DateTime(2022, 12, 9),
      DateTime(2022, 12, 10),
      DateTime(2022, 12, 11),
      DateTime(2022, 12, 13),
      DateTime(2022, 12, 20),
      DateTime(2022, 12, 21),
      DateTime(2022, 12, 23),
      DateTime(2022, 12, 24),
    ];
  }
}
