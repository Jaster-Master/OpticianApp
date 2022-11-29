import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:opticianapp/default_properties.dart';
import 'package:opticianapp/model/location.dart';
import 'package:opticianapp/model/optician.dart';
import 'package:opticianapp/widget/stateful/partnerlist.dart';
import 'package:collection/collection.dart';
import 'package:opticianapp/widget/stateful/partnerlist_details.dart';

var location = Location("country", "zipCode", "city", "street", "streetNumber");

class PartnerListView extends StatefulWidget {
  List<Optician> partner = [
    Optician("Alex", "Test", [location], location, "null", "null", "null",
        [DateTime.now().add(Duration(days: 1)), DateTime.now()], false),
    Optician("Nom", "Test", [location], location, "null", "null", "null",
        [DateTime.now().add(Duration(days: 1)), DateTime.now()], false)
  ];
  Map<String, List<Optician>> listViewValues = {};

  PartnerListView({super.key}) {
    List<String> alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ".split("");
    for (var letter in alphabet) {
      List<Optician> currentPartner = [];
      for (var value in partner) {
        if (value.name.toUpperCase().startsWith(letter)) {
          currentPartner.add(value);
        }
      }
      listViewValues[letter] = currentPartner;
    }
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
      ),
    );

    var favouritePartner =
        widget.partner.where((element) => element.isFavourite).firstOrNull;

    return Padding(
      padding: EdgeInsets.only(top: DefaultProperties.defaultPadding),
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
                      itemCount: widget.listViewValues.keys.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(
                              bottom:
                                  index == widget.listViewValues.keys.length - 1
                                      ? DefaultProperties.tripleMorePadding
                                      : 0),
                          child: PartnerListItem(
                              this,
                              openDetailsListView,
                              widget.listViewValues,
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
}

class PartnerListItem extends StatefulWidget {
  PartnerListViewState listState;
  ValueChanged<Optician> openDetailsListView;
  Map<String, List<Optician>> listViewValues = {};
  String letter;

  PartnerListItem(this.listState, this.openDetailsListView, this.listViewValues,
      this.letter,
      {super.key});

  @override
  State<StatefulWidget> createState() => PartnerListItemState();
}

class PartnerListItemState extends State<PartnerListItem> {
  @override
  Widget build(BuildContext context) {
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
    widget.listViewValues[widget.letter]?.forEach((partner) {
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
                        partner.isFavourite ? Icons.star : Icons.star_outline,
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
      var isFavourite = partner.isFavourite;
      widget.listState.widget.partner.forEach((element) {
        element.isFavourite = false;
      });
      partner.isFavourite = !isFavourite;
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
