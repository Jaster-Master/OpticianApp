import 'package:flutter/material.dart';
import 'package:opticianapp/widget/partnerlist_details/partnerlist_location_item.dart';

import '../../../default_properties.dart';
import '../../../model/optician.dart';

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