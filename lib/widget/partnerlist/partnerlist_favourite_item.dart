import 'package:flutter/material.dart';

import '../../../default_properties.dart';
import '../../../main.dart';
import '../../../model/optician.dart';

class PartnerFavouriteItem extends StatelessWidget {
  ValueChanged<Optician> openDetailsListView;
  Function onRemoveFavouritePartnerLocation;
  Optician partner;

  PartnerFavouriteItem(this.openDetailsListView,
      this.onRemoveFavouritePartnerLocation, this.partner,
      {super.key});

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
                IconButton(
                  padding: EdgeInsets.all(0),
                  onPressed: () => onRemoveFavouritePartnerLocation(),
                  icon: Icon(
                    partner.id == OpticianApp.user?.favouriteOpticianId
                        ? Icons.star
                        : Icons.star_outline,
                    color: DefaultProperties.blueColor,
                  ),
                )
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