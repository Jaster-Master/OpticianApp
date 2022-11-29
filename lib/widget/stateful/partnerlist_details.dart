import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:opticianapp/default_properties.dart';
import 'package:opticianapp/model/location.dart';
import 'package:opticianapp/model/optician.dart';

class PartnerDetailsView extends StatefulWidget {
  Optician partner;
  bool showItem = true;

  PartnerDetailsView(this.partner, {super.key});

  @override
  State<StatefulWidget> createState() => PartnerDetailsViewState();
}

class PartnerDetailsViewState extends State<PartnerDetailsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(
                right: DefaultProperties.morePadding,
                top: DefaultProperties.doubleMorePadding),
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
              "Bitte noch machen i heul",
              style: TextStyle(
                  fontSize: DefaultProperties.fontSize2,
                  color: DefaultProperties.blueColor),
            ),
          ),
          widget.showItem
              ? PartnerDetailsItemView(openLocationsView, widget.partner)
              : PartnerLocationsView(this, widget.partner),
        ],
      ),
    );
  }

  void onBackButton() {
    Navigator.pop(context);
  }

  void openLocationsView(Optician partner) {
    setState(() {
      widget.showItem = false;
    });
  }
}

class PartnerDetailsItemView extends StatelessWidget {
  ValueChanged<Optician> openLocationView;
  Optician partner;

  PartnerDetailsItemView(this.openLocationView, this.partner, {super.key});

  @override
  Widget build(BuildContext context) {
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
              Text(partner.name,
                  style: TextStyle(fontSize: DefaultProperties.fontSize1)),
              Spacer(),
              Icon(Icons.star, color: DefaultProperties.blueColor)
            ],
          ),
          GestureDetector(
            onTap: () => goToLocations(partner),
            child: Row(
              children: [
                Padding(
                  padding:
                      EdgeInsets.only(right: DefaultProperties.defaultPadding),
                  child: Icon(Icons.location_on_outlined),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        partner.locations[0].street +
                            " " +
                            partner.locations[0].streetNumber,
                        style:
                            TextStyle(fontSize: DefaultProperties.fontSize2)),
                    Text(
                        partner.locations[0].zipCode +
                            " " +
                            partner.locations[0].city,
                        style: TextStyle(fontSize: DefaultProperties.fontSize2))
                  ],
                ),
              ],
            ),
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
                        Text(partner.phoneNumber,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: Colors.black))
                      ],
                    ),
                    onPressed: () => {},
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
                      Text(partner.email,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Colors.black)),
                    ]),
                    onPressed: () => {},
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
                        Text(partner.website,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: Colors.black)),
                      ],
                    ),
                    onPressed: () => {},
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
                          style: TextStyle(color: Colors.black)),
                    ]),
                    onPressed: () => {},
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
                            style: TextStyle(color: Colors.black))
                      ],
                    ),
                    onPressed: () => {},
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void goToLocations(Optician partner) {
    openLocationView(partner);
  }
}

class PartnerLocationsView extends StatefulWidget {
  PartnerDetailsViewState currentState;
  Optician partner;

  PartnerLocationsView(this.currentState, this.partner, {super.key});

  @override
  State<StatefulWidget> createState() => PartnerLocationsViewState();
}

class PartnerLocationsViewState extends State<PartnerLocationsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(DefaultProperties.defaultPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                    onPressed: () => {Navigator.pop(context)},
                    icon: Icon(Icons.arrow_back)),
                Text("Zurück"),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(DefaultProperties.defaultPadding),
            child: Text(widget.partner.name),
          ),
          Padding(
            padding: EdgeInsets.all(DefaultProperties.defaultPadding),
            child: Text("Bitte noch machen i heul"),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(5),
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
                    itemCount: widget.partner.locations.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(
                            bottom: index == widget.partner.locations.length - 1
                                ? DefaultProperties.doubleMorePadding
                                : 0),
                        child: PartnerLocationListItem(
                            widget.currentState, widget.partner, index),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PartnerLocationListItem extends StatefulWidget {
  PartnerDetailsViewState currentState;
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
    var isFavourite = widget.partner.favouriteLocation == location;
    return Row(
      children: [
        Column(
          children: [
            Text(location.city),
            Text(location.street + " " + location.streetNumber)
          ],
        ),
        Spacer(),
        IconButton(
            onPressed: () => {makeLocationFavourite(widget.partner, location)},
            icon: Icon(isFavourite ? Icons.star : Icons.star_outline)),
        IconButton(
            onPressed: () => {goBackToDetailsItem()},
            icon: Icon(Icons.arrow_forward))
      ],
    );
  }

  void makeLocationFavourite(Optician partner, Location location) {
    partner.favouriteLocation = location;
  }

  void goBackToDetailsItem() {
    widget.currentState.setState(() {
      widget.currentState.widget.showItem = true;
    });
  }
}
