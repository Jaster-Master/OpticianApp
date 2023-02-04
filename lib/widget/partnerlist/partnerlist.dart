import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:opticianapp/data/json_reader.dart';
import 'package:opticianapp/default_properties.dart';
import 'package:opticianapp/main.dart';
import 'package:opticianapp/model/location.dart';
import 'package:opticianapp/model/optician.dart';
import 'package:opticianapp/widget/partnerlist/partnerlist_favourite_item.dart';
import 'package:opticianapp/widget/partnerlist/partnerlist_item.dart';
import 'package:opticianapp/widget/partnerlist_details/partnerlist_details.dart';

class PartnerListView extends StatefulWidget {
  Map<String, List<Optician>> partners = {};
  Map<String, List<Optician>> searchedPartners = {};

  PartnerListView({super.key}) {
    List<String> alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ".split("");
    for (var letter in alphabet) {
      List<Optician> currentPartner = [];
      for (var value in JsonReader.opticians) {
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

    var favouritePartner = JsonReader.opticians
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
                : PartnerFavouriteItem(openDetailsListView,
                    onRemoveFavouritePartnerLocation, favouritePartner),
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
    var result = Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PartnerDetailsView(partner),
      ),
    );
    result.then((value) => setState(() {}));
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

  void onRemoveFavouritePartnerLocation() {
    setState(() {
      OpticianApp.user?.favouriteOpticianId = -1;
    });
  }
}



