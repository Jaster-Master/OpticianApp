import 'package:flutter/cupertino.dart';
import 'package:opticianapp/default_properties.dart';

class PartnerListView extends StatefulWidget{
  const PartnerListView({super.key});

  @override
  State<StatefulWidget> createState() => PartnerListViewState();

}

class PartnerListViewState extends State<PartnerListView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(DefaultProperties.morePadding),
      child: Text("PartnerListe"),
    );
  }
}

class PartnerDetails extends StatelessWidget{
  const PartnerDetails({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

class PartnerLocations extends StatelessWidget{
  const PartnerLocations({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}