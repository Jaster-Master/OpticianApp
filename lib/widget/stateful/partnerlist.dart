import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:opticianapp/default_properties.dart';
import 'package:opticianapp/main.dart';
import 'package:opticianapp/model/location.dart';
import 'package:opticianapp/model/optician.dart';
import 'package:opticianapp/widget/stateful/partnerlist.dart';
import 'package:collection/collection.dart';
import 'package:opticianapp/widget/stateful/partnerlist_details.dart';

var location =
    Location(0, "country", "zipCode", "city", "street", "streetNumber");
var location2 =
    Location(0, "country2", "zipCode2", "city2", "street2", "streetNumber2");

class PartnerListView extends StatefulWidget {
  List<Optician> partner = [
    Optician(0, "Alex", "Test", [location, location2], "null", "null",
        "null", [DateTime.now().add(Duration(days: 1)), DateTime.now()]),
    Optician(1, "Nom", "Test", [location, location2], "null", "null",
        "null", [DateTime.now().add(Duration(days: 1)), DateTime.now()])
  ];
  Map<String, List<Optician>> partners = {};
  Map<String, List<Optician>> searchedPartners = {};

  PartnerListView({super.key}) {
    List<String> alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ".split("");
    for (var letter in alphabet) {
      List<Optician> currentPartner = [];
      for (var value in partner) {
        if (value.name.toUpperCase().startsWith(letter)) {
          currentPartner.add(value);
        }
      }
      partners[letter] = currentPartner;
    }
    searchedPartners = {...partners};
  }

  @override
  State<StatefulWidget> createState() => PartnerListViewState();
}

class PartnerListViewState extends State<PartnerListView> {
  @override
  Widget build(BuildContext context) {
    var tabText = Text("Partnerliste",
        style: TextStyle(fontSize: DefaultProperties.fontSize1));
    var tab = Row(
      children: [
        Row(
          children: [
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: DefaultProperties.blueColor,
                    width: 5,
                  ),
                ),
              ),
              child: tabText,
            ),
            IconButton(
              icon: Icon(Icons.local_shipping_outlined, size: 0),
              onPressed: null,
            ),
          ],
        ),
      ],
    );
    var searchField = Padding(
      padding: EdgeInsets.all(DefaultProperties.defaultPadding),
      child: TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(DefaultProperties.defaultRounded),
          ),
          labelText: 'Suchen',
        ),
        onChanged: (value) => updateNewSearch(value),
      ),
    );

    var favouritePartner = widget.partner
        .where((element) => element.id == OpticianApp.user?.favouriteOpticianId)
        .firstOrNull;

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(DefaultProperties.morePadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            tab,
            favouritePartner == null
                ? SizedBox.shrink()
                : PartnerFavouriteItem(openDetailsListView, favouritePartner),
            searchField,
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
                      itemCount: widget.searchedPartners.keys.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(
                              bottom: index ==
                                      widget.searchedPartners.keys.length - 1
                                  ? DefaultProperties.tripleMorePadding
                                  : 0),
                          child: PartnerListItem(
                              this,
                              openDetailsListView,
                              widget.searchedPartners,
                              String.fromCharCode(index + 65)),
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

  void openDetailsListView(Optician partner) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PartnerDetailsView(partner),
      ),
    );
  }

  void updateNewSearch(String value) {
    setState(() {
      if (value.isEmpty) {
        widget.searchedPartners = {...widget.partners};
        return;
      }
      for (var key in widget.searchedPartners.keys) {
        widget.searchedPartners[key] = <Optician>[];
      }
      widget.partners.forEach((key, opticianList) {
        List<Optician> matchingOpticians = opticianList
            .where((optician) =>
                optician.name.toLowerCase().contains(value.toLowerCase()))
            .toList();
        if (matchingOpticians.isNotEmpty) {
          widget.searchedPartners[key] = matchingOpticians;
        }
      });
    });
  }
}

class PartnerListItem extends StatefulWidget {
  PartnerListViewState listState;
  ValueChanged<Optician> openDetailsListView;
  Map<String, List<Optician>> partners = {};
  String letter;

  PartnerListItem(
      this.listState, this.openDetailsListView, this.partners, this.letter,
      {super.key});

  @override
  State<StatefulWidget> createState() => PartnerListItemState();
}

class PartnerListItemState extends State<PartnerListItem> {
  @override
  Widget build(BuildContext context) {
    if (widget.partners[widget.letter]!.isEmpty) {
      return SizedBox();
    }
    var letterText = Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: DefaultProperties.lightGrayColor,
            width: 1,
          ),
        ),
      ),
      child: Text(
        widget.letter,
        style: TextStyle(
            fontSize: DefaultProperties.fontSize1,
            color: DefaultProperties.grayColor),
      ),
    );
    List<Widget> partnerItems = [];
    widget.partners[widget.letter]?.forEach((partner) {
      partnerItems.add(
        InkWell(
          onTap: () => openDetailsView(partner),
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
                  Text(partner.name,
                      style: TextStyle(fontSize: DefaultProperties.fontSize1)),
                  Spacer(),
                  IconButton(
                      padding: EdgeInsets.all(0),
                      onPressed: () => onMakeFavouritePress(partner),
                      icon: Icon(
                        partner.id == OpticianApp.user?.favouriteOpticianId
                            ? Icons.star
                            : Icons.star_outline,
                        color: DefaultProperties.blueColor,
                      ))
                ],
              )),
        ),
      );
    });
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        letterText,
        Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: partnerItems)
      ],
    );
  }

  void openDetailsView(Optician partner) {
    widget.openDetailsListView(partner);
  }

  void onMakeFavouritePress(Optician partner) {
    widget.listState.setState(() {
      OpticianApp.user?.favouriteOpticianId = partner.id;
    });
  }
}

class PartnerFavouriteItem extends StatelessWidget {
  ValueChanged<Optician> openDetailsListView;
  Optician partner;

  PartnerFavouriteItem(this.openDetailsListView, this.partner, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => openDetailsListView(partner),
      child: Container(
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
            Row(
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
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(DefaultProperties.lessPadding),
                    child: SizedBox(
                      height: 50,
                      child: OutlinedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateColor.resolveWith(
                              (states) => DefaultProperties.lightBlueColor),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      DefaultProperties.defaultRounded))),
                        ),
                        child: Icon(Icons.phone_outlined),
                        onPressed: () => {},
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(DefaultProperties.lessPadding),
                    child: SizedBox(
                      height: 50,
                      child: OutlinedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateColor.resolveWith(
                              (states) => DefaultProperties.lightBlueColor),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      DefaultProperties.defaultRounded))),
                        ),
                        child: Icon(Icons.mail_outlined),
                        onPressed: () => {},
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
