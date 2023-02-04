
import 'package:flutter/material.dart';
import 'package:opticianapp/widget/partnerlist/partnerlist.dart';

import '../../../default_properties.dart';
import '../../../main.dart';
import '../../../model/optician.dart';

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
      if (OpticianApp.user?.favouriteOpticianId == partner.id) {
        OpticianApp.user?.favouriteOpticianId = -1;
      } else {
        OpticianApp.user?.favouriteOpticianId = partner.id;
      }
    });
  }
}