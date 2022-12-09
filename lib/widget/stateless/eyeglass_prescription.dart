import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:opticianapp/default_properties.dart';
import 'package:opticianapp/model/eyeglass_prescription.dart';
import 'package:opticianapp/widget/stateless/eyeglass_prescription.dart';

class EyeglassPrescriptionView extends StatefulWidget {
  List<EyeglassPrescription> eyeglassPrescriptions;

  EyeglassPrescriptionView(this.eyeglassPrescriptions, {super.key});

  @override
  State<StatefulWidget> createState() => EyeglassPrescriptionViewState();
}

class EyeglassPrescriptionViewState extends State<EyeglassPrescriptionView> {
  int index = -1;

  @override
  Widget build(BuildContext context) {
    var tabText = Text("Brillenpass",
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

    return Padding(
      padding: EdgeInsets.only(top: DefaultProperties.defaultPadding),
      child: Padding(
        padding: EdgeInsets.all(DefaultProperties.morePadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            tab,
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(DefaultProperties.lessPadding),
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
                      itemCount: widget.eyeglassPrescriptions.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(
                              bottom: index ==
                                      widget.eyeglassPrescriptions.length - 1
                                  ? DefaultProperties.doubleMorePadding
                                  : 0),
                          child: EyeglassPrescriptionItem(
                              widget.eyeglassPrescriptions[index], index),
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

class EyeglassPrescriptionItem extends StatelessWidget {
  EyeglassPrescription item;
  int index;

  EyeglassPrescriptionItem(this.item, this.index, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: DefaultProperties.morePadding),
      child: GestureDetector(
        onTap: () => {onItemPress(context, item)},
        child: Container(
          margin: EdgeInsets.all(DefaultProperties.defaultPadding),
          padding: EdgeInsets.all(DefaultProperties.defaultPadding),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius:
                BorderRadius.circular(DefaultProperties.defaultRounded),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.25),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 10.0)),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Brillenpass",
                  style: TextStyle(fontSize: DefaultProperties.fontSize2)),
              Text(
                  "vom " +
                      DefaultProperties.defaultDateFormat.format(item.date),
                  style: TextStyle(fontSize: DefaultProperties.fontSize3))
            ],
          ),
        ),
      ),
    );
  }

  void onItemPress(BuildContext context, EyeglassPrescription item) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => EyeglassPrescriptionDetailView(item)));
  }
}

class EyeglassPrescriptionDetailView extends StatelessWidget {
  EyeglassPrescription item;

  EyeglassPrescriptionDetailView(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
            top: DefaultProperties.doubleMorePadding,
            bottom: DefaultProperties.doubleMorePadding),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                      onPressed: () => {onBackButtonPress(context)},
                      icon: Icon(Icons.arrow_back)),
                  Text("Zurück",
                      style: TextStyle(fontSize: DefaultProperties.fontSize2)),
                ],
              ),
              Text(item.text ?? "",
                  style: TextStyle(fontSize: DefaultProperties.fontSize1)),
              ExpansionTile(
                title: Text("Persönlich",
                    style: TextStyle(fontSize: DefaultProperties.fontSize2)),
                children: [
                  Text(item.forename ?? "",
                      style: TextStyle(fontSize: DefaultProperties.fontSize3)),
                  Text(item.surname ?? "",
                      style: TextStyle(fontSize: DefaultProperties.fontSize3))
                ],
              ),
              Visibility(
                visible: item.type[1] == "B",
                child: ExpansionTile(
                  title: Text("Augen",
                      style: TextStyle(fontSize: DefaultProperties.fontSize2)),
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Linkes Auge",
                            style: TextStyle(
                                fontSize: DefaultProperties.fontSize3)),
                        Text(" <- Wert -> ",
                            style: TextStyle(
                                fontSize: DefaultProperties.fontSize3)),
                        Text("Rechtes Auge",
                            style: TextStyle(
                                fontSize: DefaultProperties.fontSize3)),
                      ],
                    ),
                    Text(""),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(item.sphLeft.toString() ?? "",
                            style: TextStyle(
                                fontSize: DefaultProperties.fontSize3)),
                        Text(" <- Sphäre -> ",
                            style: TextStyle(
                                fontSize: DefaultProperties.fontSize3)),
                        Text(item.sphRight.toString() ?? "",
                            style: TextStyle(
                                fontSize: DefaultProperties.fontSize3)),
                      ],
                    ),
                    Text(""),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(item.cylLeft.toString() ?? "",
                            style: TextStyle(
                                fontSize: DefaultProperties.fontSize3)),
                        Text(" <- Zylinderwert -> ",
                            style: TextStyle(
                                fontSize: DefaultProperties.fontSize3)),
                        Text(item.cylRight.toString() ?? "",
                            style: TextStyle(
                                fontSize: DefaultProperties.fontSize3)),
                      ],
                    ),
                    Text(""),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(item.pdLeft.toString() ?? "",
                            style: TextStyle(
                                fontSize: DefaultProperties.fontSize3)),
                        Text(" <- Pupillendistanz -> ",
                            style: TextStyle(
                                fontSize: DefaultProperties.fontSize3)),
                        Text(item.pdRight.toString() ?? "",
                            style: TextStyle(
                                fontSize: DefaultProperties.fontSize3)),
                      ],
                    ),
                    Text("",
                        style:
                            TextStyle(fontSize: DefaultProperties.fontSize3)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(item.hightLeft.toString() ?? "",
                            style: TextStyle(
                                fontSize: DefaultProperties.fontSize3)),
                        Text(" <- Höhe -> ",
                            style: TextStyle(
                                fontSize: DefaultProperties.fontSize3)),
                        Text(item.hightRight.toString() ?? "",
                            style: TextStyle(
                                fontSize: DefaultProperties.fontSize3)),
                      ],
                    )
                  ],
                ),
              ),
              Visibility(
                visible: item.type[1] == "B",
                child: ExpansionTile(
                  title: Text("Gläser",
                      style: TextStyle(fontSize: DefaultProperties.fontSize2)),
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Linkes Glas",
                            style: TextStyle(
                                fontSize: DefaultProperties.fontSize3)),
                        Text(" <- Wert -> ",
                            style: TextStyle(
                                fontSize: DefaultProperties.fontSize3)),
                        Text("Rechtes Glas",
                            style: TextStyle(
                                fontSize: DefaultProperties.fontSize3)),
                      ],
                    ),
                    Text("",
                        style:
                            TextStyle(fontSize: DefaultProperties.fontSize3)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(item.axisLeft.toString() ?? "",
                            style: TextStyle(
                                fontSize: DefaultProperties.fontSize3)),
                        Text(" <- Achse -> ",
                            style: TextStyle(
                                fontSize: DefaultProperties.fontSize3)),
                        Text(item.axisRight.toString() ?? "",
                            style: TextStyle(
                                fontSize: DefaultProperties.fontSize3)),
                      ],
                    ),
                    Text("",
                        style:
                            TextStyle(fontSize: DefaultProperties.fontSize3)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(item.addLeft.toString() ?? "",
                            style: TextStyle(
                                fontSize: DefaultProperties.fontSize3)),
                        Text(" <- ADD-Wert -> ",
                            style: TextStyle(
                                fontSize: DefaultProperties.fontSize3)),
                        Text(item.addRight.toString() ?? "",
                            style: TextStyle(
                                fontSize: DefaultProperties.fontSize3)),
                      ],
                    ),
                    Text("",
                        style:
                            TextStyle(fontSize: DefaultProperties.fontSize3)),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Text(item.prism1Left.toString() ?? "",
                          style:
                              TextStyle(fontSize: DefaultProperties.fontSize3)),
                      Text(" <- Prisma-1 -> ",
                          style:
                              TextStyle(fontSize: DefaultProperties.fontSize3)),
                      Text(item.prism1Right.toString() ?? "",
                          style:
                              TextStyle(fontSize: DefaultProperties.fontSize3)),
                    ]),
                    Text("",
                        style:
                            TextStyle(fontSize: DefaultProperties.fontSize3)),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Text(item.basis1Left.toString() ?? "",
                          style:
                              TextStyle(fontSize: DefaultProperties.fontSize3)),
                      Text(" <- Basis-1 -> ",
                          style:
                              TextStyle(fontSize: DefaultProperties.fontSize3)),
                      Text(item.basis1Right.toString() ?? "",
                          style:
                              TextStyle(fontSize: DefaultProperties.fontSize3)),
                    ]),
                    Text("",
                        style:
                            TextStyle(fontSize: DefaultProperties.fontSize3)),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Text(item.prism2Left.toString() ?? "",
                          style:
                              TextStyle(fontSize: DefaultProperties.fontSize3)),
                      Text(" <- Prisma-2 -> ",
                          style:
                              TextStyle(fontSize: DefaultProperties.fontSize3)),
                      Text(item.prism2Right.toString() ?? "",
                          style:
                              TextStyle(fontSize: DefaultProperties.fontSize3)),
                    ]),
                    Text("",
                        style:
                            TextStyle(fontSize: DefaultProperties.fontSize3)),
                    Container(
                      margin: EdgeInsets.only(
                          bottom: DefaultProperties.tripleMorePadding),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(item.basis2Left.toString() ?? "",
                                style: TextStyle(
                                    fontSize: DefaultProperties.fontSize3)),
                            Text(" <- Basis-2 -> ",
                                style: TextStyle(
                                    fontSize: DefaultProperties.fontSize3)),
                            Text(item.basis2Right.toString() ?? "",
                                style: TextStyle(
                                    fontSize: DefaultProperties.fontSize3)),
                          ]),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onBackButtonPress(BuildContext context) {
    Navigator.pop(context);
  }
}
