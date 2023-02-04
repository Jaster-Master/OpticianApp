import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:opticianapp/default_properties.dart';
import 'package:opticianapp/main.dart';
import 'package:opticianapp/model/location.dart';
import 'package:opticianapp/model/optician.dart';
import 'package:opticianapp/widget/partnerlist_details/partnerlist_details_item.dart';
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